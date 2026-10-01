//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'photo_suggestion_id.g.dart';

class PhotoSuggestionId extends EnumClass {

  @BuiltValueEnumConst(wireName: r'vacaciones')
  static const PhotoSuggestionId vacaciones = _$vacaciones;
  @BuiltValueEnumConst(wireName: r'auto')
  static const PhotoSuggestionId auto = _$auto;
  @BuiltValueEnumConst(wireName: r'emergencia')
  static const PhotoSuggestionId emergencia = _$emergencia;
  @BuiltValueEnumConst(wireName: r'mudanza')
  static const PhotoSuggestionId mudanza = _$mudanza;

  static Serializer<PhotoSuggestionId> get serializer => _$photoSuggestionIdSerializer;

  const PhotoSuggestionId._(String name): super(name);

  static BuiltSet<PhotoSuggestionId> get values => _$values;
  static PhotoSuggestionId valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PhotoSuggestionIdMixin = Object with _$PhotoSuggestionIdMixin;

