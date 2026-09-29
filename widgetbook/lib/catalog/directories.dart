import 'package:widgetbook/widgetbook.dart';

import 'atoms.dart';
import 'foundations.dart';
import 'molecules.dart';
import 'organisms.dart';

/// One component per `packages/ui` widget, grouped by atomic level, one use
/// case per variant.
final List<WidgetbookNode> directories = [
  foundationsFolder(),
  atomsFolder(),
  moleculesFolder(),
  organismsFolder(),
];
