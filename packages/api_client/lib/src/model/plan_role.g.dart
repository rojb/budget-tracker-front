// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PlanRole _$owner = const PlanRole._('owner');
const PlanRole _$editor = const PlanRole._('editor');
const PlanRole _$viewer = const PlanRole._('viewer');

PlanRole _$valueOf(String name) {
  switch (name) {
    case 'owner':
      return _$owner;
    case 'editor':
      return _$editor;
    case 'viewer':
      return _$viewer;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PlanRole> _$values = BuiltSet<PlanRole>(const <PlanRole>[
  _$owner,
  _$editor,
  _$viewer,
]);

class _$PlanRoleMeta {
  const _$PlanRoleMeta();
  PlanRole get owner => _$owner;
  PlanRole get editor => _$editor;
  PlanRole get viewer => _$viewer;
  PlanRole valueOf(String name) => _$valueOf(name);
  BuiltSet<PlanRole> get values => _$values;
}

mixin _$PlanRoleMixin {
  // ignore: non_constant_identifier_names
  _$PlanRoleMeta get PlanRole => const _$PlanRoleMeta();
}

Serializer<PlanRole> _$planRoleSerializer = _$PlanRoleSerializer();

class _$PlanRoleSerializer implements PrimitiveSerializer<PlanRole> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'owner': 'owner',
    'editor': 'editor',
    'viewer': 'viewer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'owner': 'owner',
    'editor': 'editor',
    'viewer': 'viewer',
  };

  @override
  final Iterable<Type> types = const <Type>[PlanRole];
  @override
  final String wireName = 'PlanRole';

  @override
  Object serialize(Serializers serializers, PlanRole object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PlanRole deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PlanRole.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
