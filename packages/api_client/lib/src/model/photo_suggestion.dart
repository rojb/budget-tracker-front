//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/photo_suggestion_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'photo_suggestion.g.dart';

/// PhotoSuggestion
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [imageUrl] - Path, relative to the API, of the suggestion's image.
@BuiltValue()
abstract class PhotoSuggestion implements Built<PhotoSuggestion, PhotoSuggestionBuilder> {
  @BuiltValueField(wireName: r'id')
  PhotoSuggestionId get id;
  // enum idEnum {  vacaciones,  auto,  emergencia,  mudanza,  };

  @BuiltValueField(wireName: r'name')
  String get name;

  /// Path, relative to the API, of the suggestion's image.
  @BuiltValueField(wireName: r'imageUrl')
  String get imageUrl;

  PhotoSuggestion._();

  factory PhotoSuggestion([void updates(PhotoSuggestionBuilder b)]) = _$PhotoSuggestion;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PhotoSuggestionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PhotoSuggestion> get serializer => _$PhotoSuggestionSerializer();
}

class _$PhotoSuggestionSerializer implements PrimitiveSerializer<PhotoSuggestion> {
  @override
  final Iterable<Type> types = const [PhotoSuggestion, _$PhotoSuggestion];

  @override
  final String wireName = r'PhotoSuggestion';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PhotoSuggestion object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(PhotoSuggestionId),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'imageUrl';
    yield serializers.serialize(
      object.imageUrl,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PhotoSuggestion object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PhotoSuggestionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PhotoSuggestionId),
          ) as PhotoSuggestionId;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'imageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PhotoSuggestion deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PhotoSuggestionBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}


