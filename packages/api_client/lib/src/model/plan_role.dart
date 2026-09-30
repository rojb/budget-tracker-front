//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'plan_role.g.dart';

/// Role of a member in a plan. `owner` manages the plan (rename, delete, and in later changes invitations); `editor` changes the plan's data; `viewer` only reads. 
class PlanRole extends EnumClass {

  @BuiltValueEnumConst(wireName: r'owner')
  static const PlanRole owner = _$owner;
  @BuiltValueEnumConst(wireName: r'editor')
  static const PlanRole editor = _$editor;
  @BuiltValueEnumConst(wireName: r'viewer')
  static const PlanRole viewer = _$viewer;

  static Serializer<PlanRole> get serializer => _$planRoleSerializer;

  const PlanRole._(String name): super(name);

  static BuiltSet<PlanRole> get values => _$values;
  static PlanRole valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PlanRoleMixin = Object with _$PlanRoleMixin;

