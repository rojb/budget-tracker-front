import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../accounts/accounts_controller.dart';
import '../common/day_groups.dart';
import '../common/months.dart';
import '../plans/plans_controller.dart';
import '../transactions/transaction_change.dart';
import '../transactions/transaction_rows.dart';
import '../transactions/transactions_controller.dart';
import 'envelopes_controller.dart';
import 'envelopes_repository.dart';
import 'goal_texts.dart';

/// Screen 22 Detalle de sobre: the figures of the month, the goal and its
/// progress, the month's activity and "Mover dinero" (FR-24). Everything comes
/// from `GET .../detail`; the state and the progress are the API's.
class EnvelopeDetailPage extends StatefulWidget {
  const EnvelopeDetailPage({
    required this.envelopeId,
    required this.plans,
    required this.envelopes,
    required this.transactions,
    required this.accounts,
    super.key,
  });

  final String envelopeId;
  final PlansController plans;
  final EnvelopesController envelopes;
  final TransactionsController transactions;
  final AccountsController accounts;

  @override
  State<EnvelopeDetailPage> createState() => _EnvelopeDetailPageState();
}

class _EnvelopeDetailPageState extends State<EnvelopeDetailPage> {
  EnvelopeDetailData? _detail;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _failed = false);
    try {
      final detail = await widget.envelopes.detail(widget.envelopeId);
      if (mounted) setState(() => _detail = detail);
    } on ApiFailure {
      if (mounted) setState(() => _failed = true);
    }
  }

  Future<void> _edit() async {
    await context.push(AppRoutes.editEnvelope(widget.envelopeId));
    if (mounted) await _load();
  }

  Future<void> _move() async {
    await context.push(AppRoutes.moveMoney(widget.envelopeId));
    if (mounted) await _load();
  }

  @override
  Widget build(BuildContext context) {
    final detail = _detail;
    final canEdit = widget.plans.activePlan?.canEdit ?? false;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          children: [
            Row(
              children: [
                UiIconButton(
                  icon: UiIcons.chevronLeft,
                  variant: UiIconButtonVariant.soft,
                  semanticLabel: 'Volver',
                  onPressed: () => context.pop(),
                ),
                const Spacer(),
                if (canEdit && detail != null)
                  UiIconButton(
                    icon: UiIcons.pencil,
                    variant: UiIconButtonVariant.soft,
                    semanticLabel: 'Editar sobre',
                    onPressed: _edit,
                  ),
              ],
            ),
            const SizedBox(height: 18),
            if (detail != null)
              ..._content(detail, canEdit)
            else if (_failed)
              _error()
            else
              const _Skeleton(),
          ],
        ),
      ),
    );
  }

  Widget _error() => UiCard(
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('No pudimos cargar el sobre', style: UiTypography.title),
        const SizedBox(height: 8),
        Text(
          'Revisá tu conexión e intentá de nuevo.',
          style: UiTypography.custom(15, color: UiColors.inkMuted),
        ),
        const SizedBox(height: 16),
        UiButton(label: 'Reintentar', onPressed: _load),
      ],
    ),
  );

  List<Widget> _content(EnvelopeDetailData detail, bool canEdit) {
    final currency = widget.plans.currency;
    final line = detail.line;
    final envelope = line.envelope;
    final monthDate = DateTime(
      int.parse(detail.month.substring(0, 4)),
      int.parse(detail.month.substring(5, 7)),
    );
    final group = widget.envelopes.groupById(envelope.groupId)?.name;
    Widget figure(String value, String label, {bool muted = false}) => Expanded(
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: UiTypography.custom(
                24,
                weight: 300,
                color: muted ? UiColors.inkMuted : UiColors.ink,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: UiTypography.custom(15, color: UiColors.inkMuted)),
        ],
      ),
    );
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 18, 0),
            child: Icon(
              uiEnvelopeIcon(envelope.icon),
              size: 30,
              color: UiColors.ink,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  envelope.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: UiTypography.custom(30),
                ),
                Text(
                  group ?? 'Sin grupo',
                  style: UiTypography.custom(16, color: UiColors.inkMuted),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 18),
      UiCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: Row(
          children: [
            figure(formatMoney(line.assignedMinor, currency), 'Asignado'),
            figure(formatMoney(line.availableMinor, currency), 'Disponible'),
            figure(
              formatMoney(line.spentMinor, currency),
              'Gastado',
              muted: true,
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      goalRow(line, currency),
      const SizedBox(height: 22),
      Text(
        'Actividad de ${monthName(monthDate)}',
        style: UiTypography.custom(22),
      ),
      const SizedBox(height: 10),
      if (detail.activity.isEmpty)
        UiCard(
          padding: const EdgeInsets.all(22),
          child: Text(
            'Sin movimientos este mes',
            style: UiTypography.custom(16, color: UiColors.inkMuted),
          ),
        )
      else
        ...buildDayGroups(
          detail.activity,
          registeredAt: (item) => item.createdAt,
          rowBuilder: (item) => transactionRow(
            item,
            currency: currency,
            envelopes: widget.envelopes,
            onTap: () => openTransaction(
              context,
              item,
              transactions: widget.transactions,
              envelopes: widget.envelopes,
              accounts: widget.accounts,
              onChanged: _load,
            ),
          ),
        ),
      if (canEdit) ...[
        const SizedBox(height: 12),
        UiButton(
          label: 'Mover dinero',
          icon: UiIcons.arrowLeftRight,
          onPressed: _move,
        ),
      ],
    ];
  }
}

/// Loading placeholder with the shape of the page, never fewer than three rows
/// so it is not mistaken for an empty list (PRD-ux-spec.md 5).
class _Skeleton extends StatelessWidget {
  const _Skeleton();

  Widget _bar(double width, double height) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: UiColors.soft,
      borderRadius: BorderRadius.circular(height / 2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Cargando el sobre',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bar(200, 30),
            const SizedBox(height: 22),
            UiCard(
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [_bar(80, 18), _bar(80, 18), _bar(80, 18)],
                ),
              ),
            ),
            const SizedBox(height: 22),
            for (var i = 0; i < 3; i++) ...[
              UiCard(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: UiColors.soft,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _bar(130, 16),
                          const SizedBox(height: 8),
                          _bar(90, 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}
