import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import '../plans/plans_controller.dart';
import 'envelope_icon_selector.dart';
import 'envelopes_controller.dart';
import 'envelopes_repository.dart';
import 'goal_fields.dart';
import 'group_picker_sheet.dart';
import '../goals/goal_photo_sheet.dart';

/// Screen 31 Nuevo sobre: name, group (→ 52), icon and the optional objective
/// ("Objetivo": none, monthly or by a date). "+ Nueva meta" in 01 opens it with
/// the group Metas and "Con fecha" preselected.
class EnvelopeFormPage extends StatefulWidget {
  const EnvelopeFormPage({
    required this.envelopes,
    required this.plans,
    this.initialGroupId,
    this.initialGoalKind,
    super.key,
  });

  final EnvelopesController envelopes;
  final PlansController plans;

  /// Group preselected by the "+" of a group header in 02 or by "+ Nueva meta".
  final String? initialGroupId;

  /// Objective preselected by "+ Nueva meta" ("Con fecha").
  final GoalKind? initialGoalKind;

  @override
  State<EnvelopeFormPage> createState() => _EnvelopeFormPageState();
}

class _EnvelopeFormPageState extends State<EnvelopeFormPage> {
  late String? _groupId = widget.envelopes.groupById(widget.initialGroupId)?.id;
  String _name = '';
  String _icon = 'tag';
  late GoalDraft _goal = widget.initialGoalKind == null
      ? const GoalDraft()
      : const GoalDraft().withKind(
          widget.initialGoalKind,
          widget.plans.currency,
        );
  String? _nameError;
  String? _dateError;
  bool _saving = false;
  PhotoChoice? _photo;

  /// The "Foto" row is for goals: group Metas or an objective with a date.
  bool get _showPhotoRow =>
      _goal.kind == GoalKind.targetByDate ||
      (widget.envelopes.groupById(_groupId)?.name.toLowerCase() == 'metas');

  String get _photoLabel => switch (_photo) {
    SuggestedChoice(:final suggestion) => suggestion.name,
    PickedChoice() => 'Tu foto',
    _ => 'Sin foto',
  };

  Future<void> _pickPhoto() async {
    final choice = await showGoalPhotoSheet(
      context,
      envelopes: widget.envelopes,
      icon: uiEnvelopeIcon(_icon),
      draftChoice: _photo,
    );
    if (choice != null) {
      setState(() => _photo = choice is NoPhotoChoice ? null : choice);
    }
  }

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
    if (_saving) return;
    if (_name.trim().isEmpty) {
      setState(() => _nameError = 'Poné un nombre para el sobre.');
      return;
    }
    if (_dueDateInvalid) {
      setState(() => _dateError = 'Elegí una fecha límite.');
      return;
    }
    setState(() => _saving = true);
    try {
      final created = await widget.envelopes.createEnvelope(
        name: _name.trim(),
        groupId: _groupId,
        icon: _icon,
        goal: _goal.toGoal(),
      );
      if (!mounted) return;
      final photo = _photo;
      var photoFailed = false;
      if (photo != null && photo is! NoPhotoChoice) {
        // The chosen photo is applied once the envelope exists.
        try {
          await applyPhotoChoice(widget.envelopes, created.id, photo);
        } on ApiFailure {
          photoFailed = true;
        }
      }
      if (!mounted) return;
      if (photoFailed) {
        showUiToast(
          context,
          variant: UiToastVariant.warning,
          title: 'El sobre se creó, pero no pudimos subir la foto',
          detail: 'Podés cambiarla desde las opciones de la meta.',
        );
      } else {
        showSaved(context, 'Guardado');
      }
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

  @override
  Widget build(BuildContext context) {
    final group = widget.envelopes.groupById(_groupId);
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
                  if (_showPhotoRow)
                    UiFieldRow(
                      label: 'Foto',
                      value: _photoLabel,
                      onTap: _pickPhoto,
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
              title: 'Objetivo (opcional)',
              error: _dateError,
              onChanged: (next) => setState(() {
                _goal = next;
                _dateError = null;
              }),
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
