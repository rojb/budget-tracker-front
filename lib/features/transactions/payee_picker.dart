import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../envelopes/envelopes_controller.dart';
import '../payees/payees_repository.dart';
import 'transaction_draft.dart';

/// What the payee picker returns: a payee (existing or typed), or "none".
sealed class PayeePickResult {
  const PayeePickResult();
}

class PayeeChosen extends PayeePickResult {
  const PayeeChosen(this.pick);

  final PayeePick pick;
}

/// The selected payee was tapped again: the movement goes without a payee.
class PayeeCleared extends PayeePickResult {
  const PayeeCleared();
}

/// Screen 26 Elegí un beneficiario: bottom sheet with an in-place search over
/// the plan's active payees (FR-23) and, when the typed text is not an exact
/// name, a last row `Crear "<text>"`. Returns the choice, or null when closed.
/// A typed name is sent as `payeeName`, which the API creates on first use.
/// [allowCreate] false (the filter of 11) offers only existing payees.
Future<PayeePickResult?> showPayeePicker(
  BuildContext context, {
  required PayeesRepository repository,
  required String planId,
  required EnvelopesController envelopes,
  PayeePick? selected,
  bool allowCreate = true,
}) {
  return showUiSheet<PayeePickResult>(
    context,
    builder: (sheetContext) => UiSheet(
      title: 'Elegí un beneficiario',
      child: _PayeePicker(
        repository: repository,
        planId: planId,
        envelopes: envelopes,
        selected: selected,
        allowCreate: allowCreate,
      ),
    ),
  );
}

class _PayeePicker extends StatefulWidget {
  const _PayeePicker({
    required this.repository,
    required this.planId,
    required this.envelopes,
    required this.selected,
    required this.allowCreate,
  });

  final PayeesRepository repository;
  final String planId;
  final EnvelopesController envelopes;
  final PayeePick? selected;
  final bool allowCreate;

  @override
  State<_PayeePicker> createState() => _PayeePickerState();
}

class _PayeePickerState extends State<_PayeePicker> {
  final TextEditingController _search = TextEditingController();
  List<PayeeData>? _payees;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _failed = false);
    try {
      final payees = await widget.repository.list(widget.planId);
      if (mounted) setState(() => _payees = payees);
    } on ApiFailure {
      if (mounted) setState(() => _failed = true);
    }
  }

  String _subtitle(PayeeData payee) {
    final id = payee.suggestedEnvelopeId;
    final name = id == null
        ? null
        : widget.envelopes.lineById(id)?.envelope.name;
    return name == null ? 'Sin sobre sugerido' : 'Sugerido: $name';
  }

  void _pick(PayeeData payee) {
    final selected = widget.selected;
    if (selected?.id == payee.id) {
      Navigator.of(context).pop(const PayeeCleared());
      return;
    }
    Navigator.of(context).pop(
      PayeeChosen(
        PayeePick(
          id: payee.id,
          name: payee.name,
          suggestedEnvelopeId: payee.suggestedEnvelopeId,
        ),
      ),
    );
  }

  Widget _body(String query) {
    final payees = _payees;
    if (_failed) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No pudimos cargar los beneficiarios.',
            style: UiTypography.custom(15, color: UiColors.inkMuted),
          ),
          const SizedBox(height: 12),
          UiButton(
            label: 'Reintentar',
            variant: UiButtonVariant.secondary,
            onPressed: _load,
          ),
        ],
      );
    }
    if (payees == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: SizedBox.square(dimension: 24, child: _Spinner())),
      );
    }
    final matches = payees
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    final exact = payees.any(
      (p) => p.name.toLowerCase() == query.toLowerCase(),
    );
    final pickedNew = widget.selected != null && widget.selected!.id == null
        ? widget.selected
        : null;
    final rows = <Widget>[
      if (pickedNew != null &&
          pickedNew.name.toLowerCase().contains(query.toLowerCase()))
        UiPayeeRow(
          variant: UiPayeeRowVariant.selectable,
          selected: true,
          initials: PayeeData(
            id: '',
            name: pickedNew.name,
            transactionCount: 0,
          ).initials,
          name: pickedNew.name,
          subtitle: 'Nuevo beneficiario',
          onTap: () => Navigator.of(context).pop(const PayeeCleared()),
        ),
      for (final payee in matches)
        UiPayeeRow(
          variant: UiPayeeRowVariant.selectable,
          selected: payee.id == widget.selected?.id,
          initials: payee.initials,
          name: payee.name,
          subtitle: _subtitle(payee),
          onTap: () => _pick(payee),
        ),
    ];
    final canCreate = widget.allowCreate && query.isNotEmpty && !exact;
    if (rows.isEmpty && !canCreate) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          widget.allowCreate
              ? 'Todavía no tenés beneficiarios. Escribí un nombre para crear uno.'
              : 'No hay beneficiarios con ese nombre.',
          style: UiTypography.custom(15, color: UiColors.inkMuted),
        ),
      );
    }
    return ListView(
      shrinkWrap: true,
      children: [
        ...rows,
        if (canCreate)
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 10),
            child: UiButton(
              label: 'Crear "${_shorten(query)}"',
              icon: UiIcons.plus,
              variant: UiButtonVariant.secondary,
              onPressed: () =>
                  Navigator.of(context)
                      .pop(PayeeChosen(PayeePick(name: _search.text.trim()))),
            ),
          ),
      ],
    );
  }

  // The design shows `Crear "Co…"`: long names are cut so the row fits.
  static String _shorten(String text) =>
      text.length <= 18 ? text : '${text.substring(0, 17)}…';

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _search,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UiTextField(
              label: 'Buscar',
              controller: _search,
              trailingIcon: UiIcons.search,
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 12),
            Flexible(
              child: UiCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                child: _body(_search.text.trim()),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) =>
      const CircularProgressIndicator(strokeWidth: 2, color: UiColors.ink);
}
