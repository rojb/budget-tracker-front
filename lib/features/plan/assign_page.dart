import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import '../common/months.dart';
import '../envelopes/envelopes_controller.dart';
import '../envelopes/envelopes_repository.dart';
import '../envelopes/goal_texts.dart';
import '../plans/plans_controller.dart';
import '../transactions/amount_expression.dart';
import 'month_controller.dart';
import 'month_keys.dart';

/// Screens 03 Asignar dinero and 53 Asignar · monto propio (one page, two
/// states): an amount, a month (the viewed one and the next three) and an
/// envelope from a carousel, confirmed with the `SaveBar`. Tapping the capsule
/// or the calculator switches to 53, with the calculator pad (FR-18) and a
/// compact card of the chosen envelope instead of the months and the carousel.
/// The amount is added to the envelope's assignment of that month (FR-09,
/// FR-10).
class AssignPage extends StatefulWidget {
  const AssignPage({
    required this.plans,
    required this.envelopes,
    required this.month,
    this.initialMonth,
    this.initialEnvelopeId,
    super.key,
  });

  final PlansController plans;
  final EnvelopesController envelopes;
  final MonthController month;

  /// "2026-11"; the viewed month of the plan when null.
  final String? initialMonth;

  /// Envelope chosen when 03 opens (from 05 "Asignar a esta meta").
  final String? initialEnvelopeId;

  @override
  State<AssignPage> createState() => _AssignPageState();
}

class _AssignPageState extends State<AssignPage> {
  final AmountExpression _amount = AmountExpression();
  late final List<String> _months;
  late String _selectedMonth;
  late final PageController _pages;

  /// Lines of [_selectedMonth]; those of the plan view until another month is
  /// chosen and loaded.
  List<EnvelopeLineData> _lines = const [];
  int _readyToAssignMinor = 0;
  String? _envelopeId;

  /// False while the amount follows the chosen envelope's need.
  bool _amountEdited = false;
  bool _typing = false;

  /// True until the first key in 53: typing writes a new amount instead of
  /// appending to the suggested one.
  bool _freshTyping = false;
  bool _saving = false;
  String? _error;

  Currency get _currency => widget.plans.currency;
  int get _units => _currency.minorUnits;
  int get _amountMinor => _amount.minor(_units) ?? 0;

  @override
  void initState() {
    super.initState();
    final viewed =
        widget.initialMonth ??
        widget.envelopes.month ??
        monthKeyOf(DateTime.now());
    _months = [for (var i = 0; i < 4; i++) shiftMonth(viewed, i)];
    _selectedMonth = viewed;
    _lines = widget.envelopes.lines;
    _readyToAssignMinor = widget.envelopes.readyToAssignMinor;
    _envelopeId = _initialEnvelope();
    _pages = PageController(
      viewportFraction: 0.66,
      initialPage: math.max(0, _indexOf(_envelopeId)),
    );
    _followNeed();
    if (widget.envelopes.month != viewed) _loadMonth(viewed);
  }

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  /// The envelope asked for, else the first one that needs money, else the
  /// first one.
  String? _initialEnvelope() {
    if (_lines.isEmpty) return null;
    final asked = widget.initialEnvelopeId;
    if (asked != null && _lines.any((l) => l.envelope.id == asked)) {
      return asked;
    }
    final needy = _lines.where((l) => _need(l) > 0).firstOrNull;
    return (needy ?? _lines.first).envelope.id;
  }

  int _indexOf(String? envelopeId) =>
      _lines.indexWhere((l) => l.envelope.id == envelopeId);

  EnvelopeLineData? get _line =>
      _lines.where((l) => l.envelope.id == _envelopeId).firstOrNull;

  /// What the envelope needs this month: its overspending, or what its goal
  /// still misses.
  int _need(EnvelopeLineData line) => switch (line.state) {
    LineState.overspent => -line.availableMinor,
    LineState.underfunded => line.goalStatus?.missingMinor ?? 0,
    LineState.funded => 0,
  };

  void _followNeed() {
    if (_amountEdited) return;
    final line = _line;
    _amount.setMinor(line == null ? 0 : _need(line), _units);
  }

  Future<void> _loadMonth(String month) async {
    try {
      final board = await widget.envelopes.boardOf(month);
      if (!mounted || month != _selectedMonth) return;
      setState(() {
        _lines = board.lines;
        _readyToAssignMinor = board.readyToAssignMinor;
        _followNeed();
      });
    } on ApiFailure {
      if (mounted) showConnectionProblem(context);
    }
  }

  void _selectMonth(String month) {
    if (month == _selectedMonth) return;
    setState(() => _selectedMonth = month);
    _loadMonth(month);
  }

  void _selectEnvelope(int index) {
    if (index < 0 || index >= _lines.length) return;
    setState(() {
      _envelopeId = _lines[index].envelope.id;
      _error = null;
      _followNeed();
    });
  }

  void _setQuick(int minor) => setState(() {
    _freshTyping = false;
    _amountEdited = true;
    _error = null;
    _amount.setMinor(minor, _units);
  });

  void _onKey(String key) => setState(() {
    if (_freshTyping) _amount.clear();
    _freshTyping = false;
    _amountEdited = true;
    _error = null;
    if (key == ',') {
      _amount.decimal();
    } else if (AmountExpression.operators.contains(key)) {
      _amount.operator(key);
    } else {
      _amount.digit(key);
    }
  });

  void _setTyping(bool typing) => setState(() {
    _freshTyping = typing && !_typing;
    _typing = typing;
  });

  void _onDelete() => setState(() {
    _freshTyping = false;
    _amountEdited = true;
    _amount.delete();
  });

  Future<void> _confirm() async {
    if (_saving) return;
    final line = _line;
    final amount = _amountMinor;
    if (line == null) return;
    if (amount <= 0) {
      setState(() => _error = 'Ingresá un monto mayor a cero');
      return;
    }
    setState(() => _saving = true);
    try {
      final month = widget.month;
      final result = await month.assign(
        month: _selectedMonth,
        envelopeId: line.envelope.id,
        amountMinor: amount,
      );
      // Back to the plan view of the month the money went to.
      if (widget.envelopes.month != _selectedMonth) {
        await month.showMonth(_selectedMonth);
      }
      if (!mounted) return;
      context.pop();
      if (result.readyToAssignMinor < 0) {
        showUiToast(
          context,
          variant: UiToastVariant.warning,
          title: 'Asignaste más de lo disponible',
          detail: 'Listo para asignar quedó en negativo.',
          bottomOffset: 100,
        );
      } else {
        showSaved(context, 'Guardado');
      }
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      failure.kind == ApiFailureKind.forbidden
          ? showForbidden(context)
          : showConnectionProblem(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _money(int minor) => formatMoney(minor, _currency);

  /// "Sobregirado", "Falta $ X", "Cubierto", "Disponible" or "Sin asignar".
  String _stateWord(EnvelopeLineData line) => switch (rowVariant(line)) {
    UiEnvelopeRowVariant.overspent => 'Sobregirado',
    UiEnvelopeRowVariant.underfunded => rowCaption(line, _currency) ?? 'Falta',
    UiEnvelopeRowVariant.empty => 'Sin asignar',
    UiEnvelopeRowVariant.funded => rowCaption(line, _currency) ?? 'Disponible',
  };

  Widget _quickChips(EnvelopeLineData? line) {
    final need = line == null ? 0 : _need(line);
    final values = [
      need > 0 ? need : 5000 * _factor,
      for (final whole in const [10000, 20000, 50000]) whole * _factor,
    ];
    return Row(
      children: [
        for (var i = 0; i < values.length; i++) ...[
          if (i > 0) const SizedBox(width: 10),
          Expanded(
            child: UiChip(
              label: AmountExpression.formatMinor(values[i], _units),
              selected: !_typing && _amountMinor == values[i],
              onPressed: () => _setQuick(values[i]),
            ),
          ),
        ],
      ],
    );
  }

  /// Quick amounts are written in whole units of the plan's currency.
  int get _factor => math.pow(10, _units).toInt();

  Widget _capsule() {
    final caption = _amount.caption;
    return Column(
      children: [
        Center(
          child: Semantics(
            button: true,
            label: 'Monto, mostrar calculadora',
            child: GestureDetector(
              onTap: () => _setTyping(true),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: UiAmountCapsule(
                  symbol: _currency.symbol,
                  value: _amount.display(_units),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 28,
          child: Center(
            child: caption == null
                ? null
                : Text(caption, style: UiTypography.caption),
          ),
        ),
      ],
    );
  }

  List<Widget> _chooser() {
    final current = widget.month.currentMonth;
    final reserving = current != null && _selectedMonth.compareTo(current) > 0;
    return [
      const SizedBox(height: 22),
      Row(
        children: [
          Text('Mes', style: UiTypography.custom(20)),
          const Spacer(),
          if (reserving)
            Text(
              'Reservás hoy',
              style: UiTypography.custom(15, color: UiColors.inkMuted),
            ),
        ],
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 10,
        children: [
          for (final month in _months)
            UiChip(
              label: _shortMonth(month),
              selected: month == _selectedMonth,
              onPressed: () => _selectMonth(month),
            ),
        ],
      ),
      const SizedBox(height: 26),
      Row(
        children: [
          Text('Elegí un sobre', style: UiTypography.custom(20)),
          const Spacer(),
          if (_lines.length > 1) _dots(),
        ],
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 180,
        child: PageView.builder(
          controller: _pages,
          itemCount: _lines.length,
          onPageChanged: _selectEnvelope,
          padEnds: true,
          clipBehavior: Clip.none,
          itemBuilder: (context, index) {
            final line = _lines[index];
            final selected = line.envelope.id == _envelopeId;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: UiAssignCard(
                icon: uiEnvelopeIcon(line.envelope.icon),
                name: line.envelope.name,
                available: '${_money(line.availableMinor)} disponible',
                caption: selected
                    ? '${_stateWord(line)} · quedaría en '
                          '${_money(line.availableMinor + _amountMinor)}'
                    : _stateWord(line),
                percent: _percent(line, selected),
                selected: selected,
                onTap: () => _pages.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeOut,
                ),
              ),
            );
          },
        ),
      ),
    ];
  }

  /// At most five page dots (as in the render): the position of the chosen
  /// envelope is scaled onto them.
  Widget _dots() {
    final count = math.min(_lines.length, 5);
    final index = math.max(0, _indexOf(_envelopeId));
    return UiPageDots(
      count: count,
      index: (index * (count - 1) / (_lines.length - 1)).round(),
    );
  }

  /// Share of the envelope's need the amount covers ("100%"); none without a
  /// need.
  String? _percent(EnvelopeLineData line, bool selected) {
    final need = _need(line);
    if (need <= 0) return null;
    final amount = selected ? _amountMinor : 0;
    return '${(amount * 100 ~/ need).clamp(0, 100)}%';
  }

  List<Widget> _ownAmount(EnvelopeLineData? line) => [
    const SizedBox(height: 18),
    if (line != null)
      UiEnvelopeRow(
        icon: uiEnvelopeIcon(line.envelope.icon),
        name: line.envelope.name,
        subtitle:
            '${_money(line.availableMinor)} disponible → quedaría en '
            '${_money(line.availableMinor + _amountMinor)}',
        subtitleMaxLines: 2,
      ),
    const SizedBox(height: 18),
    Text(
      'Listo para asignar quedaría en '
      '${_money(_readyToAssignMinor - _amountMinor)}',
      style: UiTypography.custom(16, color: UiColors.inkMuted),
    ),
    const SizedBox(height: 16),
    UiCalculatorPad(
      onKey: _onKey,
      onDelete: _onDelete,
      decimalEnabled: _units > 0,
    ),
  ];

  String _shortMonth(String key) {
    final short = monthShort(monthDate(key));
    return '${short[0].toUpperCase()}${short.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    final line = _line;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: UiIconButton(
                  icon: UiIcons.close,
                  variant: UiIconButtonVariant.soft,
                  semanticLabel: 'Cerrar',
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                children: [
                  Text('Asignar\ndinero', style: UiTypography.custom(42)),
                  const SizedBox(height: 22),
                  _capsule(),
                  _quickChips(line),
                  if (_lines.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: UiInfoNote(
                        text: 'Creá un sobre para poder asignarle dinero.',
                      ),
                    )
                  else if (_typing)
                    ..._ownAmount(line)
                  else
                    ..._chooser(),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    UiFormMessage(message: _error!),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: UiSaveBar(
                label: 'Asignar ${_money(math.max(0, _amountMinor))}',
                enabled: !_saving && line != null,
                leadingIcon: UiIcons.calculator,
                onConfirm: _confirm,
                onCalculatorPressed: () => _setTyping(!_typing),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
