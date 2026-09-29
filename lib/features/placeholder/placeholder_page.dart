import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// Stand-in for a screen a later change builds (01/02 home, 20 Nuevo plan,
/// 30 Unirse a un plan) so the navigation map of PRD-ux-spec.md §9.5 can be
/// followed end to end today.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    required this.title,
    required this.description,
    this.actionLabel,
    this.actionIcon,
    this.onAction,
    super.key,
  });

  final String title;
  final String description;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(title, style: UiTypography.headline),
              const SizedBox(height: 12),
              Text(
                description,
                style: UiTypography.custom(16, color: UiColors.inkMuted),
              ),
              const SizedBox(height: 32),
              if (actionLabel != null)
                UiButton(
                  label: actionLabel!,
                  icon: actionIcon,
                  variant: UiButtonVariant.secondary,
                  onPressed: onAction,
                ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
