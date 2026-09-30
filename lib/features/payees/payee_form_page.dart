import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

import '../../app/routes.dart';
import '../../core/api/api_failure.dart';
import '../common/edit_sheets.dart';
import '../common/feedback.dart';
import 'delete_payee_sheet.dart';
import 'payees_controller.dart';
import 'payees_repository.dart';

/// Screen 41: "Nuevo beneficiario" (no [payee]) or "Editar beneficiario".
class PayeeFormPage extends StatefulWidget {
  const PayeeFormPage({required this.controller, this.payee, super.key});

  final PayeesController controller;
  final PayeeData? payee;

  @override
  State<PayeeFormPage> createState() => _PayeeFormPageState();
}

class _PayeeFormPageState extends State<PayeeFormPage> {
  late String _name = widget.payee?.name ?? '';
  String? _nameError;
  bool _saving = false;

  bool get _editing => widget.payee != null;

  Future<void> _editName() async {
    final value = await showTextEditSheet(
      context,
      title: 'Nombre del beneficiario',
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

  Future<void> _save() async {
    if (_saving) return;
    if (_name.trim().isEmpty) {
      setState(() => _nameError = 'Poné un nombre para el beneficiario.');
      return;
    }
    setState(() => _saving = true);
    try {
      if (_editing) {
        await widget.controller.rename(widget.payee!.id, _name.trim());
      } else {
        await widget.controller.create(_name.trim());
      }
      if (!mounted) return;
      showSaved(context, 'Guardado');
      context.pop();
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      switch (failure.kind) {
        case ApiFailureKind.conflict:
          setState(
            () => _nameError = 'Ya tenés un beneficiario con ese nombre.',
          );
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

  Future<void> _delete() async {
    final payee = widget.payee!;
    final confirmed = await showDeletePayeeSheet(context, payee);
    if (confirmed != true || !mounted) return;
    try {
      await widget.controller.delete(payee.id);
      if (!mounted) return;
      showUiToast(
        context,
        variant: UiToastVariant.success,
        title: 'Beneficiario eliminado',
        detail: 'Sus movimientos pasados lo conservan.',
      );
      context.pop();
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      failure.kind == ApiFailureKind.forbidden
          ? showForbidden(context)
          : showConnectionProblem(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.payee?.movementsLabel ?? '0 movimientos';
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
                if (_editing)
                  UiIconButton(
                    icon: UiIcons.trash,
                    variant: UiIconButtonVariant.danger,
                    semanticLabel: 'Eliminar beneficiario',
                    onPressed: _delete,
                  ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              _editing ? 'Editar beneficiario' : 'Nuevo beneficiario',
              style: UiTypography.custom(36),
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
                  // The envelope picker (36) arrives with add-envelopes.
                  const UiFieldRow(label: 'Sobre', value: 'Sin sobre'),
                ],
              ),
            ),
            if (_nameError != null) ...[
              const SizedBox(height: 8),
              UiFormMessage(message: _nameError!),
            ],
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: UiFieldRow(
                label: count,
                value: 'Ver movimientos',
                onTap: () => context.push(AppRoutes.transactions),
              ),
            ),
            const SizedBox(height: 16),
            UiSaveBar(
              label: _editing ? 'Guardar cambios' : 'Crear beneficiario',
              enabled: !_saving,
              onConfirm: _save,
            ),
          ],
        ),
      ),
    );
  }
}
