import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../common/feedback.dart';
import 'delete_group_sheet.dart';
import 'envelopes_controller.dart';
import 'envelopes_repository.dart';

/// Screen 32 Grupos: reorder by dragging, rename in place, delete (→ 44) and
/// create. Reordering is saved when the drag ends.
class GroupsPage extends StatefulWidget {
  const GroupsPage({required this.envelopes, super.key});

  final EnvelopesController envelopes;

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final TextEditingController _newName = TextEditingController();
  String? _newNameError;
  bool _creating = false;

  @override
  void dispose() {
    _newName.dispose();
    super.dispose();
  }

  void _toastFor(ApiFailure failure) {
    if (!mounted) return;
    failure.kind == ApiFailureKind.forbidden
        ? showForbidden(context)
        : showConnectionProblem(context);
  }

  Future<void> _create() async {
    if (_creating) return;
    final name = _newName.text.trim();
    if (name.isEmpty) {
      setState(() => _newNameError = 'Poné un nombre para el grupo.');
      return;
    }
    setState(() => _creating = true);
    try {
      await widget.envelopes.createGroup(name);
      if (!mounted) return;
      _newName.clear();
      setState(() => _newNameError = null);
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      switch (failure.kind) {
        case ApiFailureKind.conflict:
          setState(() => _newNameError = 'Ya tenés un grupo con ese nombre.');
        case ApiFailureKind.validation:
          setState(() => _newNameError = failure.fieldErrors['name']);
        default:
          _toastFor(failure);
      }
    } finally {
      if (mounted) setState(() => _creating = false);
    }
  }

  Future<void> _rename(GroupData group) async {
    await showUiSheet<void>(
      context,
      builder: (sheetContext) => UiSheet(
        title: 'Renombrar grupo',
        child: _RenameGroup(
          initial: group.name,
          save: (name) async {
            try {
              await widget.envelopes.renameGroup(group.id, name);
              return null;
            } on ApiFailure catch (failure) {
              switch (failure.kind) {
                case ApiFailureKind.conflict:
                  return 'Ya tenés un grupo con ese nombre.';
                case ApiFailureKind.validation:
                  return failure.fieldErrors['name'] ?? 'Revisá el nombre.';
                default:
                  _toastFor(failure);
                  return 'No pudimos guardar el cambio.';
              }
            }
          },
        ),
      ),
    );
  }

  Future<void> _delete(GroupData group) async {
    final confirmed = await showDeleteGroupSheet(context, group);
    if (confirmed != true || !mounted) return;
    try {
      await widget.envelopes.deleteGroup(group.id);
      if (!mounted) return;
      showUiToast(
        context,
        variant: UiToastVariant.info,
        title: 'Grupo eliminado',
        detail: 'Sus sobres pasaron a «Sin grupo».',
      );
    } on ApiFailure catch (failure) {
      _toastFor(failure);
    }
  }

  Future<void> _reorder(List<GroupData> groups, int from, int to) async {
    final ids = [for (final g in groups) g.id];
    final moved = ids.removeAt(from);
    // onReorderItem already reports the index after the removal.
    ids.insert(to, moved);
    try {
      await widget.envelopes.reorderGroups(ids);
    } on ApiFailure catch (failure) {
      _toastFor(failure);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.envelopes,
          builder: (context, _) {
            final groups = widget.envelopes.groups;
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
                Text('Grupos', style: UiTypography.custom(36)),
                const SizedBox(height: 6),
                Text(
                  'Reordená, renombrá o borrá los grupos de tu plan.',
                  style: UiTypography.custom(16, color: UiColors.inkMuted),
                ),
                const SizedBox(height: 18),
                ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  buildDefaultDragHandles: false,
                  proxyDecorator: (child, index, animation) =>
                      Material(color: Colors.transparent, child: child),
                  onReorderItem: (from, to) => _reorder(groups, from, to),
                  children: [
                    for (final (index, group) in groups.indexed)
                      Padding(
                        key: ValueKey(group.id),
                        padding: const EdgeInsets.only(bottom: 10),
                        child: UiCard(
                          padding: const EdgeInsets.fromLTRB(6, 0, 12, 0),
                          child: UiGroupRow(
                            name: group.name,
                            subtitle: group.envelopesLabel,
                            handle: ReorderableDragStartListener(
                              index: index,
                              child: UiGroupRow.grip(),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UiIconButton(
                                  icon: UiIcons.pencil,
                                  variant: UiIconButtonVariant.soft,
                                  size: 48,
                                  iconSize: 18,
                                  semanticLabel: 'Renombrar ${group.name}',
                                  onPressed: () => _rename(group),
                                ),
                                const SizedBox(width: 8),
                                UiIconButton(
                                  icon: UiIcons.trash,
                                  variant: UiIconButtonVariant.danger,
                                  size: 48,
                                  iconSize: 18,
                                  semanticLabel: 'Eliminar ${group.name}',
                                  onPressed: () => _delete(group),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                UiTextField(
                  label: 'Nuevo grupo',
                  controller: _newName,
                  errorText: _newNameError,
                  trailingIcon: UiIcons.plus,
                  onTrailingPressed: _create,
                  textInputAction: TextInputAction.done,
                  onChanged: (_) {
                    if (_newNameError != null) {
                      setState(() => _newNameError = null);
                    }
                  },
                  onSubmitted: (_) => _create(),
                ),
                const SizedBox(height: 14),
                const UiInfoNote(
                  text:
                      'Al borrar un grupo, sus sobres pasan a «Sin grupo». No se '
                      'pierde dinero ni movimientos.',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Body of the rename sheet: keeps the sheet open and shows the error on the
/// field when [save] returns one.
class _RenameGroup extends StatefulWidget {
  const _RenameGroup({required this.initial, required this.save});

  final String initial;
  final Future<String?> Function(String name) save;

  @override
  State<_RenameGroup> createState() => _RenameGroupState();
}

class _RenameGroupState extends State<_RenameGroup> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initial,
  );
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Poné un nombre para el grupo.');
      return;
    }
    if (name == widget.initial) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => _saving = true);
    final error = await widget.save(name);
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _error = error;
        _saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UiTextField(
          label: 'Nombre',
          controller: _controller,
          errorText: _error,
          textInputAction: TextInputAction.done,
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
          onSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 16),
        UiButton(label: 'Listo', onPressed: _saving ? null : _submit),
      ],
    );
  }
}
