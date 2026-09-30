import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'accounts_controller.dart';
import 'accounts_repository.dart';

/// Screen 37 Elegí una cuenta: bottom sheet with an in-place search and the
/// active accounts (archived ones are never offered, FR-03). Returns the
/// chosen account, or null when closed. Used by 07/09/12 (transactions) and
/// 29 (transfers).
Future<AccountData?> showAccountPicker(
  BuildContext context, {
  required AccountsController accounts,
  required Currency currency,
  String? selectedId,
  String title = 'Elegí una cuenta',
  Set<String> exclude = const {},
}) {
  return showUiSheet<AccountData>(
    context,
    builder: (sheetContext) => UiSheet(
      title: title,
      child: _AccountPicker(
        accounts: accounts.active
            .where((a) => !exclude.contains(a.id))
            .toList(),
        shareOf: accounts.shareOf,
        currency: currency,
        selectedId: selectedId,
      ),
    ),
  );
}

class _AccountPicker extends StatefulWidget {
  const _AccountPicker({
    required this.accounts,
    required this.shareOf,
    required this.currency,
    required this.selectedId,
  });

  final List<AccountData> accounts;
  final double Function(AccountData) shareOf;
  final Currency currency;
  final String? selectedId;

  @override
  State<_AccountPicker> createState() => _AccountPickerState();
}

class _AccountPickerState extends State<_AccountPicker> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _search,
      builder: (context, _) {
        final query = _search.text.trim().toLowerCase();
        final rows = widget.accounts
            .where((a) => a.name.toLowerCase().contains(query))
            .toList();
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
                child: rows.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'No hay cuentas con ese nombre.',
                          style: UiTypography.custom(
                            15,
                            color: UiColors.inkMuted,
                          ),
                        ),
                      )
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          for (final account in rows)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: UiAccountRow(
                                variant: UiAccountRowVariant.selectable,
                                selected: account.id == widget.selectedId,
                                icon: account.kind.icon,
                                name: account.name,
                                subtitle: account.kind.label,
                                amount: formatMoney(
                                  account.balanceMinor,
                                  widget.currency,
                                ),
                                caption:
                                    '${(widget.shareOf(account) * 100).round()}% del total',
                                onTap: () => Navigator.of(context).pop(account),
                              ),
                            ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
