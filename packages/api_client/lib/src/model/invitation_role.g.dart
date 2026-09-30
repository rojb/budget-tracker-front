// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InvitationRole _$editor = const InvitationRole._('editor');
const InvitationRole _$viewer = const InvitationRole._('viewer');

InvitationRole _$valueOf(String name) {
  switch (name) {
    case 'editor':
      return _$editor;
    case 'viewer':
      return _$viewer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<InvitationRole> _$values =
    BuiltSet<InvitationRole>(const <InvitationRole>[
  _$editor,
  _$viewer,
]);

class _$InvitationRoleMeta {
  const _$InvitationRoleMeta();
  InvitationRole get editor => _$editor;
  InvitationRole get viewer => _$viewer;
  InvitationRole valueOf(String name) => _$valueOf(name);
  BuiltSet<InvitationRole> get values => _$values;
}

mixin _$InvitationRoleMixin {
  // ignore: non_constant_identifier_names
  _$InvitationRoleMeta get InvitationRole => const _$InvitationRoleMeta();
}

Serializer<InvitationRole> _$invitationRoleSerializer =
    _$InvitationRoleSerializer();

class _$InvitationRoleSerializer
    implements PrimitiveSerializer<InvitationRole> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'editor': 'editor',
    'viewer': 'viewer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'editor': 'editor',
    'viewer': 'viewer',
  };

  @override
  final Iterable<Type> types = const <Type>[InvitationRole];
  @override
  final String wireName = 'InvitationRole';

  @override
  Object serialize(Serializers serializers, InvitationRole object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  InvitationRole deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      InvitationRole.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
