import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import 'invite_controller.dart';
import 'sharing_repository.dart';

/// Screen 21 Invitar miembro (owner only): code, QR, share, regenerate, revoke.
class InvitePage extends StatefulWidget {
  const InvitePage({
    required this.controllerFactory,
    required this.planName,
    super.key,
  });

  final InviteController Function() controllerFactory;
  final String planName;

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  late final InviteController _controller = widget.controllerFactory();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChange);
    _controller.load();
  }

  @override
  void dispose() {
    _controller.removeListener(_onChange);
    _controller.dispose();
    super.dispose();
  }

  void _onChange() {
    final failure = _controller.failure;
    if (failure == null) return;
    failure.kind == ApiFailureKind.forbidden
        ? showForbidden(context)
        : showConnectionProblem(context);
  }

  Future<void> _copy(InvitationData invitation) async {
    await Clipboard.setData(ClipboardData(text: invitation.code));
    _controller.markCopied();
  }

  Future<void> _share(InvitationData invitation) {
    return SharePlus.instance.share(
      ShareParams(
        subject: 'Unite a ${widget.planName}',
        text:
            'Unite a ${widget.planName} en Sobres con el código '
            '${invitation.code}: ${invitation.link}',
      ),
    );
  }

  static String _time(DateTime instant) {
    final local = instant.toLocal();
    final now = DateTime.now();
    final hh = local.hour.toString().padLeft(2, '0');
    final mm = local.minute.toString().padLeft(2, '0');
    final today =
        local.year == now.year &&
        local.month == now.month &&
        local.day == now.day;
    return '${today ? 'hoy' : '${local.day}/${local.month}'} $hh:$mm';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final invitation = _controller.invitation;
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: UiIconButton(
                    icon: UiIcons.chevronLeft,
                    variant: UiIconButtonVariant.soft,
                    semanticLabel: 'Volver',
                    onPressed: () => context.pop(),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  'Invitar a ${widget.planName}',
                  style: UiTypography.custom(34),
                ),
                const SizedBox(height: 6),
                Text(
                  'Compartí el código o el QR para sumar a alguien.',
                  style: UiTypography.custom(15, color: UiColors.inkMuted),
                ),
                const SizedBox(height: 18),
                Text('Rol', style: UiTypography.custom(16)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: [
                    for (final role in InviteRole.values)
                      UiChip(
                        label: role.chip,
                        selected: role == _controller.role,
                        onPressed: _controller.busy
                            ? null
                            : () => _controller.selectRole(role),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (invitation != null) ...[
                  UiCodeCard(
                    code: invitation.code,
                    copied: _controller.copied,
                    caption: 'Vence en 24 h · un solo uso',
                    onCopy: () => _copy(invitation),
                    qr: Semantics(
                      label: 'Código QR del enlace de invitación',
                      child: QrImageView(
                        data: invitation.link,
                        size: 200,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  UiButton(
                    label: 'Compartir código',
                    icon: UiIcons.share,
                    onPressed: () => _share(invitation),
                  ),
                  const SizedBox(height: 6),
                ],
                UiButton(
                  label: 'Generar otro código',
                  icon: UiIcons.refresh,
                  variant: UiButtonVariant.secondary,
                  loading: _controller.busy,
                  onPressed: _controller.regenerate,
                ),
                const SizedBox(height: 12),
                UiCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 6,
                  ),
                  child: invitation == null
                      ? UiFieldRow(
                          label: 'No hay un código activo',
                          value: 'Generar',
                          onTap: _controller.regenerate,
                        )
                      : UiFieldRow(
                          label:
                              'Código activo · creado ${_time(invitation.createdAt)}',
                          value: 'Revocar',
                          onTap: _controller.revoke,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
