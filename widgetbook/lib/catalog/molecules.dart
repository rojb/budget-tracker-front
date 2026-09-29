import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'stage.dart';

WidgetbookFolder moleculesFolder() {
  return WidgetbookFolder(
    name: 'molecules',
    children: [
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
