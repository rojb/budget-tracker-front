import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../accounts/accounts_controller.dart';
import '../common/day_groups.dart';
import '../envelopes/envelopes_controller.dart';
import '../payees/payees_repository.dart';
import '../plans/plans_controller.dart';
import 'filter_sheet.dart';
import 'transaction_change.dart';
import 'transaction_filter.dart';
import 'transaction_rows.dart';
import 'transactions_controller.dart';

/// Screen 10 Movimientos: the plan's transactions newest first, grouped by day,
/// with more pages loaded as the list is scrolled. The header has the search
/// (a field that opens in place, FR-22) and the filters button (→ 11); every
/// active filter shows as a removable chip, and while any filter or search is on
/// a summary card shows what left and what came in over every movement it
/// selects. Tapping a movement opens 12.
class MovementsPage extends StatefulWidget {
  const MovementsPage({
    required this.transactions,
    required this.envelopes,
    required this.accounts,
    required this.plans,
    required this.payees,
    super.key,
  });

  final TransactionsController transactions;
  final EnvelopesController envelopes;
  final AccountsController accounts;
  final PlansController plans;
  final PayeesRepository payees;

  @override
  State<MovementsPage> createState() => _MovementsPageState();
}

class _MovementsPageState extends State<MovementsPage> {
  final ScrollController _scroll = ScrollController();
  final TextEditingController _search = TextEditingController();
  Timer? _debounce;
  late bool _searching = widget.transactions.filter.query.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    _search.text = widget.transactions.filter.query;
    // A tab visit shows fresh movements; the list is cheap (one page).
    widget.transactions.refresh();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    _search.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    if (_scroll.position.extentAfter < 400) widget.transactions.loadMore();
  }

  TransactionFilter get _filter => widget.transactions.filter;

  // The list follows the text once the user pauses typing.
  void _onQuery(String text) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 350),
      () => widget.transactions.setFilter(_filter.withQuery(text)),
    );
  }

  void _toggleSearch() {
    setState(() => _searching = !_searching);
    if (!_searching) {
      _debounce?.cancel();
      _search.clear();
      widget.transactions.setFilter(_filter.withQuery(''));
    }
  }

  Future<void> _openFilters() async {
    final plan = widget.plans.activePlan;
    if (plan == null) return;
    final filter = await showFilterSheet(
      context,
      initial: _filter,
      transactions: widget.transactions,
      envelopes: widget.envelopes,
      accounts: widget.accounts,
      payees: widget.payees,
      planId: plan.id,
      currency: widget.plans.currency,
    );
    widget.transactions.setFilter(filter);
  }

  void _clearAll() {
    _debounce?.cancel();
    _search.clear();
    setState(() => _searching = false);
    widget.transactions.setFilter(TransactionFilter.none);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.transactions,
        widget.envelopes,
        widget.plans,
      ]),
      builder: (context, _) {
        final transactions = widget.transactions;
        final currency = widget.plans.currency;
        final filter = transactions.filter;
        return RefreshIndicator(
          onRefresh: transactions.refresh,
          child: ListView(
            controller: _scroll,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              _header(filter),
              ..._chips(filter),
              if (filter.isActive && transactions.loaded) ...[
                const SizedBox(height: 16),
                UiJoinedCard(
                  primaryValue: formatMoney(
                    transactions.outflowMinor,
                    currency,
                  ),
                  primaryLabel: 'Salió en la franja',
                  secondaryValue: formatMoney(
                    transactions.inflowMinor,
                    currency,
                  ),
                  secondaryLabel: 'Entró',
                  secondaryIsAmount: true,
                ),
              ],
              const SizedBox(height: 14),
              ..._body(context, currency, filter),
            ],
          ),
        );
      },
    );
  }

  Widget _header(TransactionFilter filter) {
    return Row(
      children: [
        Expanded(
          child: _searching
              ? UiTextField(
                  label: 'Buscar movimiento',
                  controller: _search,
                  textInputAction: TextInputAction.search,
                  onChanged: _onQuery,
                )
              : Text('Movimientos', style: UiTypography.custom(36)),
        ),
        const SizedBox(width: 10),
        UiIconButton(
          icon: _searching ? UiIcons.close : UiIcons.search,
          semanticLabel: _searching ? 'Cerrar búsqueda' : 'Buscar',
          onPressed: _toggleSearch,
        ),
        const SizedBox(width: 8),
        UiIconButton(
          icon: UiIcons.sliders,
          variant: filter.hasFilters
              ? UiIconButtonVariant.lavender
              : UiIconButtonVariant.white,
          semanticLabel: 'Filtros',
          onPressed: _openFilters,
        ),
      ],
    );
  }

  // One removable chip per active filter (the search text has its own field).
  List<Widget> _chips(TransactionFilter filter) {
    final transactions = widget.transactions;
    final chips = <Widget>[
      if (filter.dateLabel != null)
        UiFilterChip(
          icon: UiIcons.calendar,
          label: filter.dateLabel!,
          onRemove: () => transactions.setFilter(filter.withDates(null, null)),
        ),
      if (filter.timeLabel != null)
        UiFilterChip(
          icon: UiIcons.clock,
          label: filter.timeLabel!,
          onRemove: () => transactions.setFilter(filter.withTimes(null, null)),
        ),
      if (filter.kind != TransactionKind.all)
        UiFilterChip(
          icon: UiIcons.arrowLeftRight,
          label: filter.kind == TransactionKind.expense ? 'Gastos' : 'Ingresos',
          onRemove: () =>
              transactions.setFilter(filter.withKind(TransactionKind.all)),
        ),
      if (filter.payeeId != null)
        UiFilterChip(
          icon: UiIcons.store,
          label: filter.payeeName ?? 'Beneficiario',
          onRemove: () => transactions.setFilter(filter.withPayee(null, null)),
        ),
      if (filter.envelopeId != null)
        UiFilterChip(
          icon: UiIcons.wallet,
          label: filter.envelopeName ?? 'Sobre',
          onRemove: () =>
              transactions.setFilter(filter.withEnvelope(null, null)),
        ),
      if (filter.accountId != null)
        UiFilterChip(
          icon: UiIcons.creditCard,
          label: filter.accountName ?? 'Cuenta',
          onRemove: () =>
              transactions.setFilter(filter.withAccount(null, null)),
        ),
    ];
    if (chips.isEmpty) return const [];
    return [
      const SizedBox(height: 14),
      Wrap(spacing: 8, runSpacing: 8, children: chips),
    ];
  }

  List<Widget> _body(
    BuildContext context,
    Currency currency,
    TransactionFilter filter,
  ) {
    final transactions = widget.transactions;
    if (!transactions.loaded) {
      if (transactions.failed) {
        return [
          UiCard(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'No pudimos cargar los movimientos',
                  style: UiTypography.title,
                ),
                const SizedBox(height: 8),
                Text(
                  'Revisá tu conexión e intentá de nuevo.',
                  style: UiTypography.custom(15, color: UiColors.inkMuted),
                ),
                const SizedBox(height: 16),
                UiButton(label: 'Reintentar', onPressed: transactions.refresh),
              ],
            ),
          ),
        ];
      }
      return const [_SkeletonRows()];
    }
    if (transactions.items.isEmpty) {
      if (filter.isActive) {
        return [
          UiCard(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'No hay movimientos con estos filtros',
                  style: UiTypography.custom(16, color: UiColors.inkMuted),
                ),
                const SizedBox(height: 16),
                UiButton(
                  label: 'Limpiar filtros',
                  variant: UiButtonVariant.secondary,
                  onPressed: _clearAll,
                ),
              ],
            ),
          ),
        ];
      }
      return [
        UiCard(
          padding: const EdgeInsets.all(22),
          child: Text(
            'Todavía no hay movimientos',
            style: UiTypography.custom(16, color: UiColors.inkMuted),
          ),
        ),
      ];
    }
    return [
      ...buildDayGroups(
        transactions.items,
        occurredAt: (item) => item.occurredAt,
        rowBuilder: (item) => transactionRow(
          item,
          currency: currency,
          envelopes: widget.envelopes,
          onTap: () => openTransaction(
            context,
            item,
            transactions: transactions,
            envelopes: widget.envelopes,
            accounts: widget.accounts,
          ),
        ),
      ),
      if (transactions.loadingMore)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: _Spinner()),
        ),
    ];
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) => const SizedBox.square(
    dimension: 24,
    child: CircularProgressIndicator(strokeWidth: 2, color: UiColors.ink),
  );
}

/// Loading placeholder: the shape of the real list (a day header and a card of
/// rows) in `#EDEDED` with a soft pulse, never fewer than three rows so it is
/// not mistaken for an empty list (PRD-ux-spec.md 5).
class _SkeletonRows extends StatefulWidget {
  const _SkeletonRows();

  @override
  State<_SkeletonRows> createState() => _SkeletonRowsState();
}

class _SkeletonRowsState extends State<_SkeletonRows>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

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
      label: 'Cargando movimientos',
      child: ExcludeSemantics(
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.45, end: 1).animate(_pulse),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
                child: _bar(140, 16),
              ),
              UiCard(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    for (var i = 0; i < 4; i++)
                      SizedBox(
                        height: 72,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _bar(150, 14),
                                  const SizedBox(height: 8),
                                  _bar(100, 12),
                                ],
                              ),
                            ),
                            _bar(64, 14),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
