import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

/// "Guardado" pattern of PRD-ux-spec.md §5: a Success toast after a create or
/// edit.
void showSaved(BuildContext context, String title, {String detail = ''}) {
  showUiToast(
    context,
    variant: UiToastVariant.success,
    title: title,
    detail: detail,
    duration: const Duration(milliseconds: 1500),
    // Saves return to tab screens: float over the tab bar (PRD-ux-spec.md §8).
    bottomOffset: 100,
  );
}

void showConnectionProblem(BuildContext context) {
  showUiToast(
    context,
    variant: UiToastVariant.error,
    title: 'No pudimos conectar',
    detail: 'Revisá tu conexión e intentá de nuevo.',
  );
}

void showForbidden(BuildContext context) {
  showUiToast(
    context,
    variant: UiToastVariant.warning,
    title: 'No tenés permiso para hacer esto',
    detail: 'Tu rol en este plan es de solo lectura.',
  );
}
