// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_goal_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EnvelopeGoalType _$monthly = const EnvelopeGoalType._('monthly');
const EnvelopeGoalType _$targetByDate =
    const EnvelopeGoalType._('targetByDate');

EnvelopeGoalType _$valueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$monthly;
    case 'targetByDate':
      return _$targetByDate;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EnvelopeGoalType> _$values =
    BuiltSet<EnvelopeGoalType>(const <EnvelopeGoalType>[
  _$monthly,
  _$targetByDate,
]);

class _$EnvelopeGoalTypeMeta {
  const _$EnvelopeGoalTypeMeta();
  EnvelopeGoalType get monthly => _$monthly;
  EnvelopeGoalType get targetByDate => _$targetByDate;
  EnvelopeGoalType valueOf(String name) => _$valueOf(name);
  BuiltSet<EnvelopeGoalType> get values => _$values;
}

mixin _$EnvelopeGoalTypeMixin {
  // ignore: non_constant_identifier_names
  _$EnvelopeGoalTypeMeta get EnvelopeGoalType => const _$EnvelopeGoalTypeMeta();
}

Serializer<EnvelopeGoalType> _$envelopeGoalTypeSerializer =
    _$EnvelopeGoalTypeSerializer();

class _$EnvelopeGoalTypeSerializer
    implements PrimitiveSerializer<EnvelopeGoalType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'monthly': 'monthly',
    'targetByDate': 'targetByDate',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'monthly': 'monthly',
    'targetByDate': 'targetByDate',
  };

  @override
  final Iterable<Type> types = const <Type>[EnvelopeGoalType];
  @override
  final String wireName = 'EnvelopeGoalType';

  @override
  Object serialize(Serializers serializers, EnvelopeGoalType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EnvelopeGoalType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EnvelopeGoalType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
