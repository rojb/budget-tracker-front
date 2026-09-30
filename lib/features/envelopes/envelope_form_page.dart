import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import 'envelopes_controller.dart';
import 'group_picker_sheet.dart';

/// Screen 31 Nuevo sobre: name, group (→ 52) and icon. The objective block of
/// the design ("Objetivo") arrives with `add-envelope-goals`.
class EnvelopeFormPage extends StatefulWidget {
  const EnvelopeFormPage({
    required this.envelopes,
    this.initialGroupId,
    super.key,
  });

  final EnvelopesController envelopes;

  /// Group preselected by the "+" of a group header in 02.
  final String? initialGroupId;

  @override
  State<EnvelopeFormPage> createState() => _EnvelopeFormPageState();
}

class _EnvelopeFormPageState extends State<EnvelopeFormPage> {
  /// Icons shown before the "…" button; the rest of the closed set follows it.
  static const int _visibleIcons = 6;

  late String? _groupId = widget.envelopes.groupById(widget.initialGroupId)?.id;
  String _name = '';
  String _icon = 'tag';
  String? _nameError;
  bool _moreIcons = false;
  bool _saving = false;

  Future<void> _editName() async {
    final value = await showTextEditSheet(
      context,
      title: 'Nombre del sobre',
      label: 'Nombre',
      initial: _name,
    );
    if (value != null) {
      setState(() {
        _name = value;
        _nameError = null;
      });
    }
  }

  Future<void> _pickGroup() async {
    final id = await showGroupPicker(
      context,
      envelopes: widget.envelopes,
      selectedId: _groupId,
    );
    if (id != null) setState(() => _groupId = id);
  }

  Future<void> _save() async {
    if (_saving) return;
    if (_name.trim().isEmpty) {
      setState(() => _nameError = 'Poné un nombre para el sobre.');
      return;
    }
    setState(() => _saving = true);
    try {
      await widget.envelopes.createEnvelope(
        name: _name.trim(),
        groupId: _groupId,
        icon: _icon,
      );
      if (!mounted) return;
      showSaved(context, 'Guardado');
      context.pop();
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      switch (failure.kind) {
        case ApiFailureKind.conflict:
          setState(() => _nameError = 'Ya tenés un sobre con ese nombre.');
        case ApiFailureKind.validation:
          setState(() => _nameError = failure.fieldErrors['name']);
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
    final group = widget.envelopes.groupById(_groupId);
    final names = uiEnvelopeIcons.keys.toList();
    final shown = _moreIcons ? names : names.take(_visibleIcons).toList();
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
            Text('Nuevo sobre', style: UiTypography.custom(36)),
            const SizedBox(height: 6),
            Text(
              group == null
                  ? 'Sumá un sobre a tu plan.'
                  : 'Sumá un sobre a ${group.name}.',
              style: UiTypography.custom(16, color: UiColors.inkMuted),
            ),
            const SizedBox(height: 18),
            UiCard(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Column(
                children: [
                  UiFieldRow(
                    label: 'Nombre',
                    value: _name.isEmpty ? 'Elegí un nombre' : _name,
                    onTap: _editName,
                  ),
                  UiFieldRow(
                    label: 'Grupo',
                    value: group?.name ?? 'Sin grupo',
                    onTap: _pickGroup,
                  ),
                ],
              ),
            ),
            if (_nameError != null) ...[
              const SizedBox(height: 8),
              UiFormMessage(message: _nameError!),
            ],
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text('Ícono', style: UiTypography.custom(19)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final name in shown)
                  UiIconButton(
                    icon: uiEnvelopeIcons[name]!,
                    variant: name == _icon
                        ? UiIconButtonVariant.lavender
                        : UiIconButtonVariant.white,
                    semanticLabel: 'Ícono $name',
                    onPressed: () => setState(() => _icon = name),
                  ),
                if (!_moreIcons)
                  UiIconButton(
                    icon: UiIcons.ellipsis,
                    semanticLabel: 'Más íconos',
                    onPressed: () => setState(() => _moreIcons = true),
                  ),
              ],
            ),
            const SizedBox(height: 28),
            UiSaveBar(
              label: 'Crear sobre',
              enabled: !_saving,
              onConfirm: _save,
            ),
          ],
        ),
      ),
    );
  }
}
