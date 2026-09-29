import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/router.dart';
import 'auth_hero.dart';
import 'login_controller.dart';

/// Screen 18 Acceso. Container widget: owns the [LoginController] and maps its
/// state to `packages/ui` components.
class LoginPage extends StatefulWidget {
  const LoginPage({required this.controllerFactory, super.key});

  final LoginController Function() controllerFactory;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController _controller = widget.controllerFactory();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _email.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final outcome = await _controller.submit(
      email: _email.text,
      password: _password.text,
    );
    if (!mounted || outcome != SubmitOutcome.connectionProblem) return;
    showUiToast(
      context,
      variant: UiToastVariant.error,
      title: 'No pudimos conectar',
      detail: 'Revisá tu conexión e intentá de nuevo.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 26, bottom: 24),
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: UiHeroCard(
                    title: 'Sobres',
                    subtitle: 'Cada peso con un destino, antes de gastarlo.',
                    image: authHeroImage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Iniciar sesión', style: UiTypography.title),
                      const SizedBox(height: 14),
                      UiTextField(
                        label: 'Email',
                        controller: _email,
                        trailingIcon: UiIcons.mail,
                        errorText: _controller.emailError,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        autocorrect: false,
                        enableSuggestions: false,
                        onChanged: (_) => _controller.clearErrors(),
                        onSubmitted: (_) => _passwordFocus.requestFocus(),
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        label: 'Contraseña',
                        controller: _password,
                        focusNode: _passwordFocus,
                        obscureText: _controller.obscurePassword,
                        trailingIcon: _controller.obscurePassword
                            ? UiIcons.eye
                            : UiIcons.eyeOff,
                        onTrailingPressed: _controller.togglePasswordVisibility,
                        errorText: _controller.passwordError,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        autocorrect: false,
                        enableSuggestions: false,
                        onChanged: (_) => _controller.clearErrors(),
                        onSubmitted: (_) => _submit(),
                      ),
                      if (_controller.formError != null) ...[
                        const SizedBox(height: 10),
                        UiFormMessage(message: _controller.formError!),
                      ],
                      const SizedBox(height: 10),
                      UiButton(
                        label: 'Entrar',
                        loading: _controller.loading,
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 2),
                      UiLinkRow(
                        prompt: '¿No tenés cuenta?',
                        actionLabel: 'Crear cuenta',
                        onPressed: () => context.go(AppRoutes.register),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
