import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import 'payees_controller.dart';
import 'payees_repository.dart';

/// Screen 15 Beneficiarios.
class PayeesPage extends StatefulWidget {
  const PayeesPage({required this.controller, super.key});

  final PayeesController controller;

  @override
  State<PayeesPage> createState() => _PayeesPageState();
}

class _PayeesPageState extends State<PayeesPage> {
  final TextEditingController _search = TextEditingController();
  bool _searching = false;

  @override
  void initState() {
    super.initState();
    widget.controller.load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _toggleSearch() => setState(() {
    _searching = !_searching;
    if (!_searching) _search.clear();
  });

  // Until envelopes exist every payee reads "Sin sobre" (add-envelopes fills it).
  static String subtitle(PayeeData payee) =>
      'Sin sobre · ${payee.movementsLabel}';

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: Listenable.merge([controller, _search]),
          builder: (context, _) {
            final query = _search.text.trim().toLowerCase();
            final rows = controller.payees
                .where((p) => p.name.toLowerCase().contains(query))
                .toList();
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
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
                    UiIconButton(
                      icon: _searching ? UiIcons.close : UiIcons.search,
                      variant: UiIconButtonVariant.soft,
                      semanticLabel: _searching ? 'Cerrar búsqueda' : 'Buscar',
                      onPressed: _toggleSearch,
                    ),
                    const SizedBox(width: 8),
                    UiIconButton(
                      icon: UiIcons.userPlus,
                      variant: UiIconButtonVariant.lavender,
                      semanticLabel: 'Nuevo beneficiario',
                      onPressed: () => context.push(AppRoutes.newPayee),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                if (_searching)
                  UiTextField(
                    label: 'Buscar beneficiario',
                    controller: _search,
                    textInputAction: TextInputAction.search,
                  )
                else
                  Text('Beneficiarios', style: UiTypography.custom(36)),
                const SizedBox(height: 18),
                if (controller.payees.isEmpty && !controller.loading)
                  UiCard(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.failed
                              ? 'No pudimos cargar tus beneficiarios'
                              : 'Todavía no tenés beneficiarios',
                          style: UiTypography.title,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Se crean solos la primera vez que los usás en un '
                          'movimiento.',
                          style: UiTypography.custom(
                            15,
                            color: UiColors.inkMuted,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (rows.isEmpty && query.isNotEmpty)
                  UiCard(
                    padding: const EdgeInsets.all(22),
                    child: Text(
                      'Ningún beneficiario coincide con "${_search.text.trim()}".',
                      style: UiTypography.custom(15, color: UiColors.inkMuted),
                    ),
                  )
                else if (rows.isNotEmpty)
                  UiCard(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        for (final (i, payee) in rows.indexed)
                          UiPayeeRow(
                            initials: payee.initials,
                            name: payee.name,
                            subtitle: subtitle(payee),
                            highlighted: i == 0,
                            onTap: () =>
                                context.push(AppRoutes.payee(payee.id)),
                          ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                const UiInfoNote(
                  icon: UiIcons.lightbulb,
                  text:
                      'Al elegir un beneficiario, su sobre sugerido se completa '
                      'solo.',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
