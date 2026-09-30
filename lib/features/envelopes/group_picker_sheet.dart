import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import 'envelopes_controller.dart';

/// Screen 52 Elegir grupo: a bottom sheet with the plan's groups (radio rows, no
/// search field: with so few groups it is optional, PRD-ux-spec.md section 6.1
/// rule 9) and an expandable "+ Nuevo grupo" row. Returns the id of the chosen
/// (or just created) group, or null when dismissed.
Future<String?> showGroupPicker(
  BuildContext context, {
  required EnvelopesController envelopes,
  String? selectedId,
}) {
  return showUiSheet<String>(
    context,
    builder: (sheetContext) => UiSheet(
      title: 'Elegí un grupo',
      child: _GroupPicker(envelopes: envelopes, selectedId: selectedId),
    ),
  );
}

class _GroupPicker extends StatefulWidget {
  const _GroupPicker({required this.envelopes, required this.selectedId});

  final EnvelopesController envelopes;
  final String? selectedId;

  @override
  State<_GroupPicker> createState() => _GroupPickerState();
}

class _GroupPickerState extends State<_GroupPicker> {
  final TextEditingController _name = TextEditingController();
  bool _creating = false;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    if (_saving) return;
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Poné un nombre para el grupo.');
      return;
    }
    setState(() => _saving = true);
    try {
      final group = await widget.envelopes.createGroup(name);
      if (!mounted) return;
      Navigator.of(context).pop(group.id);
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      switch (failure.kind) {
        case ApiFailureKind.conflict:
          setState(() => _error = 'Ya tenés un grupo con ese nombre.');
        case ApiFailureKind.validation:
          setState(() => _error = failure.fieldErrors['name']);
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
    final envelopes = widget.envelopes;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UiCard(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: Column(
              children: [
                for (final group in envelopes.groups)
                  UiGroupRow(
                    variant: UiGroupRowVariant.selectable,
                    selected: group.id == widget.selectedId,
                    name: group.name,
                    subtitle: group.envelopesLabel,
                    onTap: () => Navigator.of(context).pop(group.id),
                  ),
                if (!_creating)
                  _NewGroupRow(onTap: () => setState(() => _creating = true)),
              ],
            ),
          ),
          if (_creating) ...[
            const SizedBox(height: 12),
            UiTextField(
              label: 'Nombre del grupo',
              controller: _name,
              errorText: _error,
              trailingIcon: UiIcons.close,
              onTrailingPressed: () => setState(() {
                _creating = false;
                _error = null;
                _name.clear();
              }),
              textInputAction: TextInputAction.done,
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              onSubmitted: (_) => _create(),
            ),
            const SizedBox(height: 12),
            UiButton(label: 'Crear', onPressed: _saving ? null : _create),
          ],
        ],
      ),
    );
  }
}

/// Last row of the list: expands the new group field in place.
class _NewGroupRow extends StatelessWidget {
  const _NewGroupRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Nuevo grupo',
      excludeSemantics: true,
      onTap: onTap,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: UiColors.bg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(UiIcons.plus, size: 22, color: UiColors.ink),
              ),
              const SizedBox(width: 14),
              Text('Nuevo grupo', style: UiTypography.custom(17, weight: 500)),
            ],
          ),
        ),
      ),
    );
  }
}
