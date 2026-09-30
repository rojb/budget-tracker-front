import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../envelopes/envelopes_controller.dart';
import '../envelopes/envelopes_repository.dart';

/// What the envelope picker returns: an envelope, or "Listo para asignar".
sealed class EnvelopePick {
  const EnvelopePick();
}

class EnvelopeChosen extends EnvelopePick {
  const EnvelopeChosen(this.envelopeId);

  final String envelopeId;
}

class ReadyToAssignChosen extends EnvelopePick {
  const ReadyToAssignChosen();
}

/// Screen 36 Elegí un sobre: bottom sheet with an in-place search and the
/// plan's envelopes under UPPERCASE group dividers ("SIN GRUPO" last), each
/// with its Available of the loaded month. Returns the choice, or null when
/// closed. [offerReadyToAssign] adds "Listo para asignar" as the first row
/// (an income can go there); [exclude] hides envelopes another portion of a
/// split already uses.
Future<EnvelopePick?> showEnvelopePicker(
  BuildContext context, {
  required EnvelopesController envelopes,
  required Currency currency,
  String? selectedId,
  bool readyToAssignSelected = false,
  bool offerReadyToAssign = false,
  Set<String> exclude = const {},
}) {
  return showUiSheet<EnvelopePick>(
    context,
    builder: (sheetContext) => UiSheet(
      title: 'Elegí un sobre',
      child: _EnvelopePicker(
        envelopes: envelopes,
        currency: currency,
        selectedId: selectedId,
        readyToAssignSelected: readyToAssignSelected,
        offerReadyToAssign: offerReadyToAssign,
        exclude: exclude,
      ),
    ),
  );
}

class _EnvelopePicker extends StatefulWidget {
  const _EnvelopePicker({
    required this.envelopes,
    required this.currency,
    required this.selectedId,
    required this.readyToAssignSelected,
    required this.offerReadyToAssign,
    required this.exclude,
  });

  final EnvelopesController envelopes;
  final Currency currency;
  final String? selectedId;
  final bool readyToAssignSelected;
  final bool offerReadyToAssign;
  final Set<String> exclude;

  @override
  State<_EnvelopePicker> createState() => _EnvelopePickerState();
}

class _EnvelopePickerState extends State<_EnvelopePicker> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Widget _row(EnvelopeLineData line, String groupName) {
    final available = line.availableMinor;
    final overspent = available < 0;
    final caption = overspent
        ? 'Sobregirado'
        : (available == 0 ? 'Sin asignar' : 'Disponible');
    return UiEnvelopePickRow(
      icon: uiEnvelopeIcon(line.envelope.icon),
      name: line.envelope.name,
      subtitle: groupName,
      amount: formatMoney(available, widget.currency),
      caption: caption,
      overspent: overspent,
      selected: line.envelope.id == widget.selectedId,
      onTap: () => Navigator.of(context).pop(EnvelopeChosen(line.envelope.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _search,
      builder: (context, _) {
        final query = _search.text.trim().toLowerCase();
        bool visible(EnvelopeLineData line) =>
            !widget.exclude.contains(line.envelope.id) &&
            line.envelope.name.toLowerCase().contains(query);
        final children = <Widget>[];
        if (widget.offerReadyToAssign && 'listo para asignar'.contains(query)) {
          children.add(
            UiEnvelopePickRow(
              icon: UiIcons.inbox,
              name: 'Listo para asignar',
              subtitle: 'Sin sobre',
              amount: formatMoney(
                widget.envelopes.readyToAssignMinor,
                widget.currency,
              ),
              caption: 'Disponible',
              selected: widget.readyToAssignSelected,
              onTap: () =>
                  Navigator.of(context).pop(const ReadyToAssignChosen()),
            ),
          );
        }
        for (final group in widget.envelopes.groups) {
          final lines = widget.envelopes
              .linesOf(group.id)
              .where(visible)
              .toList();
          if (lines.isEmpty) continue;
          children.add(UiSectionLabel(group.name));
          children.addAll(lines.map((line) => _row(line, group.name)));
        }
        final ungrouped = widget.envelopes
            .linesOf(null)
            .where(visible)
            .toList();
        if (ungrouped.isNotEmpty) {
          children.add(const UiSectionLabel('Sin grupo'));
          children.addAll(ungrouped.map((line) => _row(line, 'Sin grupo')));
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UiTextField(
              label: 'Buscar',
              controller: _search,
              trailingIcon: UiIcons.search,
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 12),
            Flexible(
              child: UiCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 4,
                ),
                child: children.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'No hay sobres con ese nombre.',
                          style: UiTypography.custom(
                            15,
                            color: UiColors.inkMuted,
                          ),
                        ),
                      )
                    : ListView(shrinkWrap: true, children: children),
              ),
            ),
          ],
        );
      },
    );
  }
}
