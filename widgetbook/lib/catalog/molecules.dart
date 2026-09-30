import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stage.dart';

WidgetbookFolder moleculesFolder() {
  return WidgetbookFolder(
    name: 'molecules',
    children: [
      WidgetbookComponent(
        name: 'EnvelopeRow',
        useCases: [
          WidgetbookUseCase(
            name: 'variants (02)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: Column(
                  children: [
                    UiEnvelopeRow(
                      variant: UiEnvelopeRowVariant.overspent,
                      icon: UiIcons.bus,
                      name: 'Transporte',
                      subtitle: r'$ 51.200 de $ 45.000',
                      amount: formatMoney(-6200, Currency.ars),
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    UiEnvelopeRow(
                      icon: UiIcons.cart,
                      name: 'Supermercado',
                      subtitle: r'$ 132.450 de $ 180.000',
                      amount: formatMoney(47550, Currency.ars),
                      progress: 0.74,
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    UiEnvelopeRow(
                      variant: UiEnvelopeRowVariant.underfunded,
                      icon: UiIcons.pill,
                      name: 'Farmacia',
                      subtitle: r'$ 0 de $ 30.000',
                      amount: formatMoney(12000, Currency.ars),
                      caption: r'Falta $ 18.000',
                      progress: 0.4,
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    UiEnvelopeRow(
                      variant: UiEnvelopeRowVariant.empty,
                      icon: UiIcons.wifi,
                      name: 'Internet y celular',
                      subtitle: r'$ 0 de $ 0',
                      amount: formatMoney(0, Currency.ars),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'summary without amounts (43)',
            builder: (context) => stage(
              const SizedBox(
                width: 380,
                child: UiCard(
                  child: UiEnvelopeRow(
                    card: false,
                    icon: UiIcons.cart,
                    name: 'Supermercado',
                    subtitle: r'Día a día · $ 47.550 disponible',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'EnvelopeTickRow',
        useCases: [
          WidgetbookUseCase(
            name: 'ticked and unticked (35)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: Column(
                  children: [
                    const UiSectionLabel('Día a día'),
                    UiEnvelopeTickRow(
                      icon: UiIcons.bus,
                      name: 'Transporte',
                      ticked: true,
                      onTap: () {},
                    ),
                    UiEnvelopeTickRow(
                      icon: UiIcons.cart,
                      name: 'Supermercado',
                      ticked: true,
                      onTap: () {},
                    ),
                    UiEnvelopeTickRow(
                      icon: UiIcons.pill,
                      name: 'Farmacia',
                      ticked: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'EnvelopeAmountRow',
        useCases: [
          WidgetbookUseCase(
            name: 'assigned and empty (46)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: Column(
                  children: [
                    const UiSectionLabel('Obligaciones'),
                    UiEnvelopeAmountRow(
                      icon: UiIcons.house,
                      name: 'Alquiler',
                      amount: formatMoney(280000, Currency.ars),
                      assigned: true,
                      onTap: () {},
                    ),
                    UiEnvelopeAmountRow(
                      icon: UiIcons.settings,
                      name: 'Servicios',
                      amount: formatMoney(0, Currency.ars),
                      assigned: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'GroupHeader',
        useCases: [
          WidgetbookUseCase(
            name: 'with "+" (02)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: Column(
                  children: [
                    UiGroupHeader(
                      name: 'Día a día',
                      subtitle: r'$ 85.350 disponible',
                      onAdd: () {},
                    ),
                    UiGroupHeader(
                      name: 'Obligaciones',
                      subtitle: r'$ 415.700 disponible',
                      onAdd: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'without "+" (Sin grupo)',
            builder: (context) => stage(
              const SizedBox(
                width: 380,
                child: UiGroupHeader(
                  name: 'Sin grupo',
                  subtitle: r'$ 0 disponible',
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'GroupRow',
        useCases: [
          WidgetbookUseCase(
            name: 'manage (32)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: Column(
                  children: [
                    for (final g in _demoGroups) ...[
                      UiCard(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: UiGroupRow(
                          name: g.$1,
                          subtitle: g.$2,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UiIconButton(
                                icon: UiIcons.pencil,
                                variant: UiIconButtonVariant.soft,
                                semanticLabel: 'Renombrar ${g.$1}',
                                onPressed: () {},
                              ),
                              const SizedBox(width: 6),
                              UiIconButton(
                                icon: UiIcons.trash,
                                variant: UiIconButtonVariant.danger,
                                semanticLabel: 'Eliminar ${g.$1}',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'selectable (52)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiCard(
                  child: Column(
                    children: [
                      for (final g in _demoGroups)
                        UiGroupRow(
                          variant: UiGroupRowVariant.selectable,
                          selected: g.$1 == 'Día a día',
                          name: g.$1,
                          subtitle: g.$2,
                          onTap: () {},
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'summary (44)',
            builder: (context) => stage(
              const SizedBox(
                width: 380,
                child: UiCard(
                  child: UiGroupRow(
                    variant: UiGroupRowVariant.summary,
                    name: 'Día a día',
                    subtitle: '4 sobres',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'TextField',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (context) => stage(
              const SizedBox(
                width: 340,
                child: _DemoField(trailingIcon: UiIcons.mail),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'focus',
            builder: (context) => stage(
              const SizedBox(
                width: 340,
                child: _DemoField(trailingIcon: UiIcons.mail, autofocus: true),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'error',
            builder: (context) => stage(
              const SizedBox(
                width: 340,
                child: _DemoField(
                  trailingIcon: UiIcons.eye,
                  errorText: 'Revisá el valor ingresado',
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'password (obscured, eye toggle)',
            builder: (context) => stage(const _PasswordDemo()),
          ),
          WidgetbookUseCase(
            name: 'icons (user, mail, eye-off)',
            builder: (context) => stage(
              const SizedBox(
                width: 340,
                child: Column(
                  children: [
                    _DemoField(trailingIcon: UiIcons.user),
                    SizedBox(height: 10),
                    _DemoField(trailingIcon: UiIcons.mail),
                    SizedBox(height: 10),
                    _DemoField(trailingIcon: UiIcons.eyeOff),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'MonthSwitch',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiMonthSwitch(
                  label: 'Septiembre 2026',
                  onPrevious: () {},
                  onNext: () {},
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AccountRow',
        useCases: [
          WidgetbookUseCase(
            name: 'standard (13)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: Column(
                  children: [
                    for (final a in _demoAccounts) ...[
                      UiCard(
                        child: UiAccountRow(
                          icon: a.$1,
                          name: a.$2,
                          subtitle: a.$3,
                          amount: formatMoney(a.$4, Currency.ars),
                          caption: '${(a.$5 * 100).round()}% del total',
                          share: a.$5,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'selectable (37)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiCard(
                  child: Column(
                    children: [
                      for (final a in _demoAccounts)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: UiAccountRow(
                            variant: UiAccountRowVariant.selectable,
                            selected: a.$2 == 'Banco Nación',
                            icon: a.$1,
                            name: a.$2,
                            subtitle: a.$3,
                            amount: formatMoney(a.$4, Currency.ars),
                            caption: '${(a.$5 * 100).round()}% del total',
                            onTap: () {},
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'archived (51)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiCard(
                  child: UiAccountRow(
                    variant: UiAccountRowVariant.archived,
                    icon: UiIcons.landmark,
                    name: 'Brubank',
                    subtitle: 'Banco · archivada el 12 ago',
                    amount: formatMoney(0, Currency.ars),
                    trailing: UiChip(
                      label: 'Restaurar',
                      selected: true,
                      size: UiChipSize.compact,
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'PlanRow',
        useCases: [
          WidgetbookUseCase(
            name: 'active and inactive (16)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: Column(
                  children: [
                    UiPlanRow(
                      title: 'Mi plan',
                      subtitle: r'Solo vos · pesos ($)',
                      active: true,
                      icon: UiIcons.wallet,
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    UiPlanRow(
                      title: 'Casa con Juli',
                      subtitle: r'Compartido · 2 miembros · pesos ($)',
                      initials: const ['SO', 'JU'],
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    UiPlanRow(
                      title: 'Viaje a Chile',
                      subtitle: r'Solo vos · dólares (US$)',
                      initials: const ['SO'],
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'TxRow',
        useCases: [
          WidgetbookUseCase(
            name: 'expense and income (14)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiCard(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      UiTxRow(
                        icon: UiIcons.arrowLeftRight,
                        title: 'Transferencia a Mercado Pago',
                        subtitle: 'Sin sobre · 15:04',
                        amount: '−${formatMoney(20000, Currency.ars)}',
                        onTap: () {},
                      ),
                      UiTxRow(
                        icon: UiIcons.arrowLeftRight,
                        title: 'Transferencia de Banco Nación',
                        subtitle: 'Sin sobre · 15:04',
                        amount: formatMoney(20000, Currency.ars),
                        variant: UiTxRowVariant.income,
                        caption: 'Entró',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'PayeeRow',
        useCases: [
          WidgetbookUseCase(
            name: 'list (15)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: UiCard(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      UiPayeeRow(
                        initials: 'CO',
                        name: 'Coto',
                        subtitle: 'Supermercado · 14 movimientos',
                        highlighted: true,
                        onTap: () {},
                      ),
                      UiPayeeRow(
                        initials: 'ED',
                        name: 'Edenor',
                        subtitle: 'Servicios · 1 movimiento',
                        onTap: () {},
                      ),
                      UiPayeeRow(
                        initials: 'EP',
                        name: 'Estudio Pérez SRL',
                        subtitle: 'Listo para asignar · 1 movimiento',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'MemberRow',
        useCases: [
          WidgetbookUseCase(
            name: 'owner and editor (16)',
            builder: (context) => stage(
              const SizedBox(
                width: 380,
                child: UiCard(
                  child: Column(
                    children: [
                      UiMemberRow(
                        initials: 'SO',
                        name: 'Sofía (vos)',
                        email: 'sofia@correo.com',
                        role: 'Dueña',
                      ),
                      SizedBox(height: 8),
                      UiMemberRow(
                        initials: 'JU',
                        name: 'Julián',
                        email: 'julian@correo.com',
                        role: 'Puede editar',
                        avatarColor: UiColors.chartreuse,
                        onRoleTap: _noop,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'MenuRow',
        useCases: [
          WidgetbookUseCase(
            name: 'default and destructive (39)',
            builder: (context) => stage(
              SizedBox(
                width: 380,
                child: Column(
                  children: [
                    UiCard(
                      child: Column(
                        children: [
                          UiMenuRow(
                            icon: UiIcons.layers,
                            label: 'Planes y miembros',
                            onTap: () {},
                          ),
                          UiMenuRow(
                            icon: UiIcons.contact,
                            label: 'Beneficiarios',
                            onTap: () {},
                          ),
                          UiMenuRow(
                            icon: UiIcons.keyRound,
                            label: 'Unirme con código',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    UiMenuRow(
                      icon: UiIcons.logOut,
                      label: 'Cerrar sesión',
                      destructive: true,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'CodeCard',
        useCases: [
          WidgetbookUseCase(
            name: 'code with QR slot (21)',
            builder: (context) => stage(const _CodeCardDemo()),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'CurrencySelector',
        useCases: [
          WidgetbookUseCase(
            name: 'pesos selected (20)',
            builder: (context) => stage(const _CurrencyDemo()),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'FieldRow',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (context) => stage(
              SizedBox(
                width: 350,
                child: UiFieldRow(label: 'Campo', value: 'Valor', onTap: () {}),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AmountCapsule',
        useCases: [
          WidgetbookUseCase(
            name: 'default',
            builder: (context) => stage(const UiAmountCapsule(value: '0')),
          ),
          WidgetbookUseCase(
            name: 'usd',
            builder: (context) =>
                stage(const UiAmountCapsule(symbol: r'US$', value: '1.250,50')),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'HeroCard',
        useCases: [
          WidgetbookUseCase(
            name: 'photo (Acceso, 320)',
            builder: (context) => stage(
              const SizedBox(
                width: 362,
                child: UiHeroCard(
                  title: 'Sobres',
                  subtitle: 'Cada peso con un destino, antes de gastarlo.',
                  image: AssetImage('assets/hero.jpg'),
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'photo (Crear cuenta, 260)',
            builder: (context) => stage(
              const SizedBox(
                width: 362,
                child: UiHeroCard(
                  title: 'Empezá',
                  subtitle: 'Un plan propio, con tus cuentas y tus sobres.',
                  height: 260,
                  image: AssetImage('assets/hero.jpg'),
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'no image (gradient fallback)',
            builder: (context) => stage(
              const SizedBox(
                width: 362,
                child: UiHeroCard(
                  title: 'Sobres',
                  subtitle: 'Cada peso con un destino, antes de gastarlo.',
                  height: 260,
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'OptionCard',
        useCases: [
          WidgetbookUseCase(
            name: 'lavender',
            builder: (context) => stage(
              SizedBox(
                width: 350,
                child: UiOptionCard(
                  icon: UiIcons.sparkles,
                  title: 'Crear mi plan',
                  description:
                      'Armá tu plan desde cero, con tus cuentas y tus sobres.',
                  variant: UiOptionCardVariant.lavender,
                  onPressed: () {},
                ),
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'white',
            builder: (context) => stage(
              SizedBox(
                width: 350,
                child: UiOptionCard(
                  icon: UiIcons.qrCode,
                  title: 'Tengo un código',
                  description: 'Alguien ya te invitó a un plan compartido. Ingresá el código o escaneá el QR.',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'Toast',
        useCases: [
          for (final v in UiToastVariant.values)
            WidgetbookUseCase(
              name: v.name,
              builder: (context) => stage(_toast(v)),
            ),
          WidgetbookUseCase(
            name: 'live (one at a time, 4 s)',
            builder: (context) => stage(const _ToastLive()),
          ),
        ],
      ),
    ],
  );
}

Widget _toast(UiToastVariant v) {
  switch (v) {
    case UiToastVariant.neutral:
      return UiToast(
        variant: v,
        title: 'Recalculado',
        detail: 'Agosto y septiembre actualizados.',
        actionLabel: 'Deshacer',
        onAction: () {},
      );
    case UiToastVariant.success:
      return UiToast(
        variant: v,
        title: 'Movimiento guardado',
        detail: r'Supermercado · −$ 18.450',
      );
    case UiToastVariant.info:
      return UiToast(
        variant: v,
        title: 'Código copiado',
        detail: 'K7M-4QX listo para compartir.',
      );
    case UiToastVariant.warning:
      return UiToast(
        variant: v,
        title: 'Transporte quedó sobregirado',
        detail: 'Cubrilo antes de cerrar el mes.',
      );
    case UiToastVariant.error:
      return UiToast(
        variant: v,
        title: 'No se pudo guardar',
        detail: 'Revisá tu conexión e intentá de nuevo.',
      );
  }
}

class _DemoField extends StatefulWidget {
  const _DemoField({
    required this.trailingIcon,
    this.autofocus = false,
    this.errorText,
  });

  final IconData trailingIcon;
  final bool autofocus;
  final String? errorText;

  @override
  State<_DemoField> createState() => _DemoFieldState();
}

class _DemoFieldState extends State<_DemoField> {
  final FocusNode _node = FocusNode();
  final TextEditingController _controller = TextEditingController(
    text: 'Value',
  );

  @override
  void initState() {
    super.initState();
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _node.requestFocus());
    }
  }

  @override
  void dispose() {
    _node.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UiTextField(
      label: 'Label',
      controller: _controller,
      focusNode: _node,
      trailingIcon: widget.trailingIcon,
      errorText: widget.errorText,
    );
  }
}

class _PasswordDemo extends StatefulWidget {
  const _PasswordDemo();

  @override
  State<_PasswordDemo> createState() => _PasswordDemoState();
}

class _PasswordDemoState extends State<_PasswordDemo> {
  final TextEditingController _controller = TextEditingController(
    text: 'secreto123',
  );
  bool _obscured = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: UiTextField(
        label: 'Contraseña',
        controller: _controller,
        obscureText: _obscured,
        trailingIcon: _obscured ? UiIcons.eye : UiIcons.eyeOff,
        onTrailingPressed: () => setState(() => _obscured = !_obscured),
        autofillHints: const [AutofillHints.password],
        textInputAction: TextInputAction.done,
        autocorrect: false,
        enableSuggestions: false,
      ),
    );
  }
}

class _ToastLive extends StatelessWidget {
  const _ToastLive();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final v in UiToastVariant.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              width: 260,
              child: UiButton(
                label: 'Mostrar ${v.name}',
                variant: UiButtonVariant.secondary,
                onPressed: () => showUiToast(
                  context,
                  variant: v,
                  title: 'Toast ${v.name}',
                  detail: 'Se cierra en 4 s o deslizando.',
                  actionLabel: v == UiToastVariant.neutral ? 'Deshacer' : null,
                  onAction: () {},
                ),
              ),
            ),
          ),
      ],
    );
  }
}

const _demoGroups = [
  ('Día a día', '4 sobres'),
  ('Obligaciones', '3 sobres'),
  ('Disfrutar', '3 sobres'),
  ('Metas', '2 sobres'),
];

const _demoAccounts = [
  (UiIcons.landmark, 'Banco Nación', 'Cuenta sueldo', 842300, 0.84),
  (UiIcons.smartphone, 'Mercado Pago', 'Billetera virtual', 121200, 0.12),
  (UiIcons.banknote, 'Efectivo', 'Billetera', 36500, 0.04),
];

class _CurrencyDemo extends StatefulWidget {
  const _CurrencyDemo();

  @override
  State<_CurrencyDemo> createState() => _CurrencyDemoState();
}

class _CurrencyDemoState extends State<_CurrencyDemo> {
  Currency _selected = Currency.ars;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: UiCurrencySelector(
        selected: _selected,
        onChanged: (currency) => setState(() => _selected = currency),
      ),
    );
  }
}

void _noop() {}

class _CodeCardDemo extends StatefulWidget {
  const _CodeCardDemo();

  @override
  State<_CodeCardDemo> createState() => _CodeCardDemoState();
}

class _CodeCardDemoState extends State<_CodeCardDemo> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: UiCodeCard(
        code: 'K7M-4QX',
        copied: _copied,
        caption: 'Vence en 24 h · un solo uso',
        qr: Container(width: 180, height: 180, color: UiColors.soft),
        onCopy: () {
          setState(() => _copied = true);
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) setState(() => _copied = false);
          });
        },
      ),
    );
  }
}
