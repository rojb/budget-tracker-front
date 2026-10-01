import 'package:flutter/widgets.dart';

import '../atoms/hit_target.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

enum UiTxRowVariant { expense, income }

/// Movement row (TxRow of PRD-ux-spec.md §8): icon circle, title, subtitle
/// ("Supermercado · 14:32"), the amount and an optional caption. Income shows
/// the amount in a lavender capsule; expense as plain text with its `−` sign
/// (§7 Moneda). No chevron: the right column is a two-line stack (§8). The row is
/// 72 px tall at least; a long title or subtitle wraps to a second line and the
/// row grows instead of cutting it with an ellipsis.
class UiTxRow extends StatelessWidget {
  const UiTxRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.caption,
    this.variant = UiTxRowVariant.expense,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  /// Formatted amount, with `−` for money that left ("−$ 20.000").
  final String amount;
  final String? caption;
  final UiTxRowVariant variant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final income = variant == UiTxRowVariant.income;
    final amountText = Text(
      amount,
      style: UiTypography.custom(17, weight: 500),
    );
    final content = ExcludeSemantics(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 72),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
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
                child: Icon(icon, size: 22, color: UiColors.ink),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(18),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: UiTypography.custom(14, color: UiColors.inkMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (income)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: UiColors.lavender,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: amountText,
                    )
                  else
                    amountText,
                  if (caption != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      caption!,
                      style: UiTypography.custom(13, color: UiColors.inkMuted),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
    final label = [title, subtitle, amount, ?caption].join(', ');
    if (onTap == null) {
      return Semantics(container: true, label: label, child: content);
    }
    return UiHitTarget(
      onTap: onTap,
      semanticLabel: label,
      minWidth: 0,
      child: content,
    );
  }
}
