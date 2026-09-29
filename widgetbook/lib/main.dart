import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'catalog/directories.dart';

void main() {
  runApp(const CatalogApp());
}

/// Widgetbook catalog for `packages/ui`. Directories are declared by hand
/// (no code generation).
class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(directories: directories);
  }
}
