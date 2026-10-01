// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_suggestion_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PhotoSuggestionId _$vacaciones = const PhotoSuggestionId._('vacaciones');
const PhotoSuggestionId _$auto = const PhotoSuggestionId._('auto');
const PhotoSuggestionId _$emergencia = const PhotoSuggestionId._('emergencia');
const PhotoSuggestionId _$mudanza = const PhotoSuggestionId._('mudanza');

PhotoSuggestionId _$valueOf(String name) {
  switch (name) {
    case 'vacaciones':
      return _$vacaciones;
    case 'auto':
      return _$auto;
    case 'emergencia':
      return _$emergencia;
    case 'mudanza':
      return _$mudanza;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PhotoSuggestionId> _$values =
    BuiltSet<PhotoSuggestionId>(const <PhotoSuggestionId>[
  _$vacaciones,
  _$auto,
  _$emergencia,
  _$mudanza,
]);

class _$PhotoSuggestionIdMeta {
  const _$PhotoSuggestionIdMeta();
  PhotoSuggestionId get vacaciones => _$vacaciones;
  PhotoSuggestionId get auto => _$auto;
  PhotoSuggestionId get emergencia => _$emergencia;
  PhotoSuggestionId get mudanza => _$mudanza;
  PhotoSuggestionId valueOf(String name) => _$valueOf(name);
  BuiltSet<PhotoSuggestionId> get values => _$values;
}

mixin _$PhotoSuggestionIdMixin {
  // ignore: non_constant_identifier_names
  _$PhotoSuggestionIdMeta get PhotoSuggestionId =>
      const _$PhotoSuggestionIdMeta();
}

Serializer<PhotoSuggestionId> _$photoSuggestionIdSerializer =
    _$PhotoSuggestionIdSerializer();

class _$PhotoSuggestionIdSerializer
    implements PrimitiveSerializer<PhotoSuggestionId> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'vacaciones': 'vacaciones',
    'auto': 'auto',
    'emergencia': 'emergencia',
    'mudanza': 'mudanza',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'vacaciones': 'vacaciones',
    'auto': 'auto',
    'emergencia': 'emergencia',
    'mudanza': 'mudanza',
  };

  @override
  final Iterable<Type> types = const <Type>[PhotoSuggestionId];
  @override
  final String wireName = 'PhotoSuggestionId';

  @override
  Object serialize(Serializers serializers, PhotoSuggestionId object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PhotoSuggestionId deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PhotoSuggestionId.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
