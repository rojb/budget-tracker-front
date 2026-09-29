import 'package:flutter/material.dart';

/// Throwaway widget that demonstrates the container -> packages/ui wiring
/// and the Widgetbook catalog. Replaced by real components in `ui-foundation`.
class PlaceholderCard extends StatelessWidget {
  const PlaceholderCard({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(message),
      ),
    );
  }
}
