import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import 'join_controller.dart';
import 'join_page.dart';
import 'sharing_repository.dart';

/// Screen 45 Unirse desde enlace: `sobres.app/unirse/<code>` with the code
/// already loaded and a preview of the plan (no amounts).
class JoinLinkPage extends StatefulWidget {
  const JoinLinkPage({
    required this.code,
    required this.repository,
    required this.controllerFactory,
    this.onOpen,
    super.key,
  });

  final String code;
  final SharingRepository repository;
  final JoinController Function() controllerFactory;

  /// Called once when the page opens (clears the pending link code).
  final VoidCallback? onOpen;

  @override
  State<JoinLinkPage> createState() => _JoinLinkPageState();
}

class _JoinLinkPageState extends State<JoinLinkPage> {
  late final JoinController _controller = widget.controllerFactory();
  InvitationPreviewData? _preview;
  bool _invalid = false;

  static const Map<Currency, String> _currencyNames = {
    Currency.ars: r'pesos ($)',
    Currency.usd: r'dólares (US$)',
    Currency.eur: 'euros (€)',
  };

  String get _displayCode {
    final c = widget.code.replaceAll('-', '').toUpperCase();
    return c.length == 6 ? '${c.substring(0, 3)}-${c.substring(3)}' : c;
  }

  @override
  void initState() {
    super.initState();
    widget.onOpen?.call();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final preview = await widget.repository.preview(widget.code);
      if (mounted) setState(() => _preview = preview);
    } on ApiFailure {
      if (mounted) setState(() => _invalid = true);
    }
  }

  Future<void> _join() async {
    final outcome = await _controller.join(widget.code);
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
    final preview = _preview;
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
                  icon: UiIcons.close,
                  semanticLabel: 'Cerrar',
                  onPressed: () => context.go(AppRoutes.home),
                ),
              ),
              const SizedBox(height: 22),
              Text('Te invitaron a un plan', style: UiTypography.custom(34)),
              const SizedBox(height: 6),
              Text(
                'Abriste el enlace de invitación. Revisá el plan antes de unirte.',
                style: UiTypography.custom(15, color: UiColors.inkMuted),
              ),
              const SizedBox(height: 18),
              if (_invalid)
                const UiFormMessage(message: JoinController.invalidCode)
              else if (preview != null)
                UiPlanRow(
                  title: preview.planName,
                  subtitle:
                      'Administrado por ${preview.ownerName} · '
                      '${_currencyNames[preview.currency]} · rol '
                      '${preview.role.chip}',
                  initials: [_initials(preview.ownerName)],
                ),
              const SizedBox(height: 14),
              UiCard(
                padding: const EdgeInsets.symmetric(vertical: 22),
                child: Column(
                  children: [
                    Text('Código de invitación', style: UiTypography.caption),
                    const SizedBox(height: 8),
                    Text(
                      _displayCode,
                      style: UiTypography.custom(38, weight: 500),
                    ),
                  ],
                ),
              ),
              if (_controller.error != null) ...[
                const SizedBox(height: 12),
                UiFormMessage(message: _controller.error!),
              ],
              const SizedBox(height: 18),
              if (preview != null)
                UiButton(
                  label: 'Unirme a ${preview.planName}',
                  icon: UiIcons.check,
                  loading: _controller.loading,
                  onPressed: _join,
                ),
              const SizedBox(height: 10),
              UiButton(
                label: 'No soy yo / usar otro código',
                variant: UiButtonVariant.white,
                onPressed: () => context.go(AppRoutes.joinPlan),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _initials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed.substring(0, trimmed.length < 2 ? 1 : 2).toUpperCase();
  }
}
