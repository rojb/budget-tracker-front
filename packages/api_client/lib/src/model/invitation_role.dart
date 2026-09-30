//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invitation_role.g.dart';

/// Role an invitation grants, or a member can be given (the owner role is not transferable).
class InvitationRole extends EnumClass {

  @BuiltValueEnumConst(wireName: r'editor')
  static const InvitationRole editor = _$editor;
  @BuiltValueEnumConst(wireName: r'viewer')
  static const InvitationRole viewer = _$viewer;

  static Serializer<InvitationRole> get serializer => _$invitationRoleSerializer;

  const InvitationRole._(String name): super(name);

  static BuiltSet<InvitationRole> get values => _$values;
  static InvitationRole valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class InvitationRoleMixin = Object with _$InvitationRoleMixin;

