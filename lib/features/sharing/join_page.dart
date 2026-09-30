import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../common/feedback.dart';
import 'join_controller.dart';

/// Screen 30 Unirse a un plan: type the code, or read the QR with the phone
/// camera (it opens the link, → 45).
class JoinPage extends StatefulWidget {
  const JoinPage({
    required this.controllerFactory,
    this.initialCode,
    super.key,
  });

  final JoinController Function() controllerFactory;
  final String? initialCode;

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  late final JoinController _controller = widget.controllerFactory();
  late final TextEditingController _code = TextEditingController(
    text: widget.initialCode ?? '',
  );
  bool _scan = false;

  @override
  void dispose() {
    _controller.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _join() async {
    final outcome = await _controller.join(_code.text);
    if (!mounted) return;
    switch (outcome) {
      case JoinOutcome.joined:
        showJoined(context, _controller.joined!.name);
        context.go(AppRoutes.plan);
      case JoinOutcome.rejected:
        break;
      case JoinOutcome.connectionProblem:
        showConnectionProblem(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: UiIconButton(
                  icon: UiIcons.chevronLeft,
                  variant: UiIconButtonVariant.soft,
                  semanticLabel: 'Volver',
                  onPressed: () => context.canPop()
                      ? context.pop()
                      : context.go(AppRoutes.home),
                ),
              ),
              const SizedBox(height: 22),
              Text('Unirse a un plan', style: UiTypography.custom(36)),
              const SizedBox(height: 6),
              Text(
                'Ingresá el código que te compartieron o escaneá el QR.',
                style: UiTypography.custom(15, color: UiColors.inkMuted),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                children: [
                  UiChip(
                    label: 'Ingresar código',
                    selected: !_scan,
                    onPressed: () => setState(() => _scan = false),
                  ),
                  UiChip(
                    label: 'Escanear QR',
                    selected: _scan,
                    onPressed: () => setState(() => _scan = true),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (_scan)
                UiCard(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      const Icon(UiIcons.camera, size: 36, color: UiColors.ink),
                      const SizedBox(height: 12),
                      Text(
                        'Abrí la cámara del teléfono y apuntá al código QR: el '
                        'enlace abre la app con el código ya cargado.',
                        textAlign: TextAlign.center,
                        style: UiTypography.custom(
                          15,
                          color: UiColors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                )
              else ...[
                UiTextField(
                  label: 'Código',
                  controller: _code,
                  trailingIcon: UiIcons.hash,
                  errorText: _controller.error,
                  autocorrect: false,
                  enableSuggestions: false,
                  textInputAction: TextInputAction.go,
                  onChanged: (_) => _controller.clearError(),
                  onSubmitted: (_) => _join(),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Te lo pasa quien administra el plan.',
                    style: UiTypography.caption,
                  ),
                ),
                const SizedBox(height: 18),
                UiButton(
                  label: 'Unirme',
                  icon: UiIcons.logIn,
                  loading: _controller.loading,
                  onPressed: _join,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Success toast after joining (PRD-ux-spec.md §8, Success).
void showJoined(BuildContext context, String planName) {
  showUiToast(
    context,
    variant: UiToastVariant.success,
    title: 'Te uniste a $planName',
    detail: 'Ya podés ver el plan.',
    // Over the tab bar of the Plan tab it lands on (PRD-ux-spec.md §8).
    bottomOffset: 100,
  );
}
