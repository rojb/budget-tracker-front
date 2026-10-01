import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import '../plans/plans_controller.dart';
import 'delete_envelope_sheet.dart';
import 'envelope_icon_selector.dart';
import 'envelopes_controller.dart';
import 'envelopes_repository.dart';
import 'goal_fields.dart';
import 'group_picker_sheet.dart';
import '../goals/goal_photo_sheet.dart';

/// Screen 23 Editar sobre: name, group (→ 52), icon, the objective (type,
/// target and due date) and the trash that opens 43 (the only entry to the
/// deletion, PRD-ux-spec.md 6.1 rule 2). Saving sends the changed name, group
/// and icon and sets or removes the goal, then returns to 22.
class EnvelopeEditPage extends StatefulWidget {
  const EnvelopeEditPage({
    required this.envelopeId,
    required this.plans,
    required this.envelopes,
    super.key,
  });

  final String envelopeId;
  final PlansController plans;
  final EnvelopesController envelopes;

  @override
  State<EnvelopeEditPage> createState() => _EnvelopeEditPageState();
}

class _EnvelopeEditPageState extends State<EnvelopeEditPage> {
  late final EnvelopeLineData? _line = widget.envelopes.lineById(
    widget.envelopeId,
  );
  late String _name = _line?.envelope.name ?? '';
  late String? _groupId = _line?.envelope.groupId;
  late String _icon = _line?.envelope.icon ?? 'tag';
  late GoalDraft _goal = GoalDraft.of(_line?.envelope.goal);
  String? _nameError;
  String? _dateError;
  bool _saving = false;

  /// The "Foto" row is for goals: group Metas or an objective with a date.
  bool get _showPhotoRow =>
      _goal.kind == GoalKind.targetByDate ||
      (widget.envelopes.groupById(_groupId)?.name.toLowerCase() == 'metas');

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

  bool get _dueDateInvalid {
    final date = _goal.dueDate;
    if (_goal.kind != GoalKind.targetByDate) return false;
    if (date == null) return true;
    final now = DateTime.now();
    return date.year * 12 + date.month < now.year * 12 + now.month;
  }

  Future<void> _save() async {
    final line = _line;
    if (_saving || line == null) return;
    if (!(widget.plans.activePlan?.canEdit ?? false)) {
      showForbidden(context);
      return;
    }
    if (_name.trim().isEmpty) {
      setState(() => _nameError = 'Poné un nombre para el sobre.');
      return;
    }
    if (_dueDateInvalid) {
      setState(() => _dateError = 'Elegí una fecha límite.');
      return;
    }
    final envelope = line.envelope;
    setState(() => _saving = true);
    try {
      await widget.envelopes.saveEnvelope(
        envelope.id,
        name: _name.trim() == envelope.name ? null : _name.trim(),
        icon: _icon == envelope.icon ? null : _icon,
        groupId: _groupId == envelope.groupId ? null : _groupId,
        goal: _goal.toGoal(),
        hadGoal: envelope.goal != null,
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
          final message = failure.fieldErrors['name'];
          if (message != null) {
            setState(() => _nameError = message);
          } else {
            showConnectionProblem(context);
          }
        case ApiFailureKind.forbidden:
          showForbidden(context);
        default:
          showConnectionProblem(context);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    final line = _line;
    if (line == null) return;
    final group = widget.envelopes.groupById(line.envelope.groupId);
    final confirmed = await showDeleteEnvelopeSheet(
      context,
      line: line,
      groupName: group?.name,
      currency: widget.plans.currency,
    );
    if (confirmed != true || !mounted) return;
    try {
      await widget.envelopes.deleteEnvelope(line.envelope.id);
      if (!mounted) return;
      context.go(AppRoutes.plan);
      showUiToast(
        context,
        variant: UiToastVariant.info,
        title: 'Sobre eliminado',
        detail: 'Su disponible volvió a Listo para asignar.',
        bottomOffset: 100,
      );
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      failure.kind == ApiFailureKind.forbidden
          ? showForbidden(context)
          : showConnectionProblem(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final line = _line;
    if (line == null) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiIconButton(
                  icon: UiIcons.chevronLeft,
                  variant: UiIconButtonVariant.soft,
                  semanticLabel: 'Volver',
                  onPressed: () => context.pop(),
                ),
                const SizedBox(height: 24),
                Text('No encontramos el sobre', style: UiTypography.title),
              ],
            ),
          ),
        ),
      );
    }
    final group = widget.envelopes.groupById(_groupId);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Row(
              children: [
                UiIconButton(
                  icon: UiIcons.chevronLeft,
                  variant: UiIconButtonVariant.soft,
                  semanticLabel: 'Volver',
                  onPressed: () => context.pop(),
                ),
                const Spacer(),
                UiIconButton(
                  icon: UiIcons.trash,
                  variant: UiIconButtonVariant.danger,
                  semanticLabel: 'Eliminar sobre',
                  onPressed: _delete,
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text('Editar sobre', style: UiTypography.custom(36)),
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
                  if (_showPhotoRow)
                    UiFieldRow(
                      label: 'Foto',
                      value: line.envelope.photoUrl == null
                          ? 'Elegir'
                          : 'Cambiar',
                      onTap: () => showGoalPhotoSheet(
                        context,
                        envelopes: widget.envelopes,
                        icon: uiEnvelopeIcon(_icon),
                        envelopeId: line.envelope.id,
                      ),
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
            EnvelopeIconSelector(
              selected: _icon,
              onSelected: (name) => setState(() => _icon = name),
            ),
            const SizedBox(height: 26),
            GoalFields(
              draft: _goal,
              currency: widget.plans.currency,
              error: _dateError,
              onChanged: (next) => setState(() {
                _goal = next;
                _dateError = null;
              }),
            ),
            const SizedBox(height: 28),
            UiSaveBar(
              label: 'Guardar cambios',
              enabled: !_saving,
              onConfirm: _save,
            ),
          ],
        ),
      ),
    );
  }
}
