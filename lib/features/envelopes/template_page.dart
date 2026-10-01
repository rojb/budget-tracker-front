import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import '../plans/plans_controller.dart';
import 'envelopes_controller.dart';
import 'envelopes_repository.dart';
import 'faded_scroll.dart';

/// Screen 35 Plantilla sugerida: the template's envelopes from the API, all
/// ticked, untickable one by one. "Crear N sobres" creates the ticked ones
/// without a goal and with a zero amount in the plan currency, then opens 46.
class TemplatePage extends StatefulWidget {
  const TemplatePage({
    required this.envelopes,
    required this.plans,
    super.key,
  });

  final EnvelopesController envelopes;
  final PlansController plans;

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  List<TemplateGroupData>? _template;
  final Set<String> _ticked = {};
  bool _failed = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _failed = false);
    try {
      final template = await widget.envelopes.template();
      if (!mounted) return;
      setState(() {
        _template = template;
        _ticked
          ..clear()
          ..addAll(template.expand((g) => g.envelopes.map((e) => e.name)));
      });
    } on ApiFailure {
      if (mounted) setState(() => _failed = true);
    }
  }

  void _toggle(String name) => setState(() {
    if (!_ticked.remove(name)) _ticked.add(name);
  });

  Future<void> _create() async {
    if (_saving || _ticked.isEmpty) return;
    setState(() => _saving = true);
    try {
      await widget.envelopes.applyTemplate(_ticked.toList());
      if (!mounted) return;
      context.go(AppRoutes.assignMoney);
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      switch (failure.kind) {
        case ApiFailureKind.conflict:
          // The plan got envelopes meanwhile: the tab shows them.
          await widget.envelopes.load();
          if (mounted) context.go(AppRoutes.plan);
        case ApiFailureKind.forbidden:
          showForbidden(context);
        default:
          showConnectionProblem(context);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final template = _template;
    final count = _ticked.length;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: UiIconButton(
                  icon: UiIcons.chevronLeft,
                  semanticLabel: 'Volver',
                  onPressed: () => context.pop(),
                ),
              ),
              const SizedBox(height: 18),
              Text('Plantilla sugerida', style: UiTypography.custom(34)),
              const SizedBox(height: 6),
              Text(
                'Elegí qué sobres crear. Podés desmarcar los que no quieras.',
                style: UiTypography.custom(16, color: UiColors.inkMuted),
              ),
              Expanded(
                child: template == null
                    ? Center(
                        child: _failed
                            ? UiButton(
                                label: 'Reintentar',
                                variant: UiButtonVariant.secondary,
                                onPressed: _load,
                              )
                            : null,
                      )
                    : FadedScroll(
                        child: ListView(
                          padding: const EdgeInsets.only(bottom: 40),
                          children: [
                            for (final group in template) ...[
                              UiSectionLabel(group.name),
                              for (final envelope in group.envelopes)
                                UiEnvelopeTickRow(
                                  icon: uiEnvelopeIcon(envelope.icon),
                                  name: envelope.name,
                                  ticked: _ticked.contains(envelope.name),
                                  onTap: () => _toggle(envelope.name),
                                ),
                            ],
                          ],
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    const SizedBox(width: 4),
                    const Icon(
                      UiIcons.info,
                      size: 20,
                      color: UiColors.inkMuted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Se crean sin objetivo y en '
                        '${formatMoney(0, widget.plans.currency)}. '
                        'Después los ajustás.',
                        style: UiTypography.custom(
                          15,
                          color: UiColors.inkMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              UiButton(
                label: count == 0
                    ? 'Elegí al menos un sobre'
                    : 'Crear $count ${count == 1 ? 'sobre' : 'sobres'}',
                icon: UiIcons.sparkles,
                loading: _saving,
                onPressed: count == 0 ? null : _create,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
