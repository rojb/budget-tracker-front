import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../accounts/accounts_controller.dart';
import '../common/day_groups.dart';
import '../envelopes/envelopes_controller.dart';
import '../plans/plans_controller.dart';
import 'transaction_change.dart';
import 'transaction_rows.dart';
import 'transactions_controller.dart';

/// Screen 10 Movimientos: the plan's transactions newest first, grouped by day,
/// with more pages loaded as the list is scrolled. Tapping a movement opens 12.
class MovementsPage extends StatefulWidget {
  const MovementsPage({
    required this.transactions,
    required this.envelopes,
    required this.accounts,
    required this.plans,
    super.key,
  });

  final TransactionsController transactions;
  final EnvelopesController envelopes;
  final AccountsController accounts;
  final PlansController plans;

  @override
  State<MovementsPage> createState() => _MovementsPageState();
}

class _MovementsPageState extends State<MovementsPage> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    // A tab visit shows fresh movements; the list is cheap (one page).
    widget.transactions.refresh();
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    if (_scroll.position.extentAfter < 400) widget.transactions.loadMore();
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
        return RefreshIndicator(
          onRefresh: transactions.refresh,
          child: ListView(
            controller: _scroll,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              Text('Movimientos', style: UiTypography.custom(36)),
              const SizedBox(height: 14),
              ..._body(context, currency),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _body(BuildContext context, Currency currency) {
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
