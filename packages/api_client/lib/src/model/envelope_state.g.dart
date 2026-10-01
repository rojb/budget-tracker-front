// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EnvelopeState _$funded = const EnvelopeState._('funded');
const EnvelopeState _$underfunded = const EnvelopeState._('underfunded');
const EnvelopeState _$overspent = const EnvelopeState._('overspent');

EnvelopeState _$valueOf(String name) {
  switch (name) {
    case 'funded':
      return _$funded;
    case 'underfunded':
      return _$underfunded;
    case 'overspent':
      return _$overspent;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EnvelopeState> _$values =
    BuiltSet<EnvelopeState>(const <EnvelopeState>[
  _$funded,
  _$underfunded,
  _$overspent,
]);

class _$EnvelopeStateMeta {
  const _$EnvelopeStateMeta();
  EnvelopeState get funded => _$funded;
  EnvelopeState get underfunded => _$underfunded;
  EnvelopeState get overspent => _$overspent;
  EnvelopeState valueOf(String name) => _$valueOf(name);
  BuiltSet<EnvelopeState> get values => _$values;
}

mixin _$EnvelopeStateMixin {
  // ignore: non_constant_identifier_names
  _$EnvelopeStateMeta get EnvelopeState => const _$EnvelopeStateMeta();
}

Serializer<EnvelopeState> _$envelopeStateSerializer =
    _$EnvelopeStateSerializer();

class _$EnvelopeStateSerializer implements PrimitiveSerializer<EnvelopeState> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'funded': 'funded',
    'underfunded': 'underfunded',
    'overspent': 'overspent',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'funded': 'funded',
    'underfunded': 'underfunded',
    'overspent': 'overspent',
  };

  @override
  final Iterable<Type> types = const <Type>[EnvelopeState];
  @override
  final String wireName = 'EnvelopeState';

  @override
  Object serialize(Serializers serializers, EnvelopeState object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EnvelopeState deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EnvelopeState.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
