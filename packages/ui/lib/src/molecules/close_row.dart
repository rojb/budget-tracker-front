import 'package:flutter/widgets.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

/// One line of 25 Cierre de mes: the envelope [name] and what happens to its
/// money. A carry-over reads on one line ("Alquiler · +$ 380.000 se
/// arrastra"); a [deducted] overspending is stacked under the name and red
/// ("−$ 6.200 se descuenta de Listo para asignar"), so the state is told by
/// the text as well as the colour.
class UiCloseRow extends StatelessWidget {
  const UiCloseRow({
    required this.name,
    required this.outcome,
    this.deducted = false,
    super.key,
  });

  final String name;
  final String outcome;
  final bool deducted;

  @override
  Widget build(BuildContext context) {
    final nameText = Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: UiTypography.custom(15, color: UiColors.inkMuted),
    );
    return Semantics(
      container: true,
      label: '$name, $outcome',
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: deducted
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    nameText,
                    const SizedBox(height: 4),
                    Text(
                      outcome,
                      style: UiTypography.custom(16, color: UiColors.danger),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: nameText),
                    const SizedBox(width: 12),
                    Text(outcome, style: UiTypography.custom(16)),
                  ],
                ),
        ),
      ),
    );
  }
}
