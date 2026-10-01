//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/photo_suggestion_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'suggested_photo_request.g.dart';

/// SuggestedPhotoRequest
///
/// Properties:
/// * [suggestionId] 
@BuiltValue()
abstract class SuggestedPhotoRequest implements Built<SuggestedPhotoRequest, SuggestedPhotoRequestBuilder> {
  @BuiltValueField(wireName: r'suggestionId')
  PhotoSuggestionId get suggestionId;
  // enum suggestionIdEnum {  vacaciones,  auto,  emergencia,  mudanza,  };

  SuggestedPhotoRequest._();

  factory SuggestedPhotoRequest([void updates(SuggestedPhotoRequestBuilder b)]) = _$SuggestedPhotoRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SuggestedPhotoRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SuggestedPhotoRequest> get serializer => _$SuggestedPhotoRequestSerializer();
}

class _$SuggestedPhotoRequestSerializer implements PrimitiveSerializer<SuggestedPhotoRequest> {
  @override
  final Iterable<Type> types = const [SuggestedPhotoRequest, _$SuggestedPhotoRequest];

  @override
  final String wireName = r'SuggestedPhotoRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SuggestedPhotoRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'suggestionId';
    yield serializers.serialize(
      object.suggestionId,
      specifiedType: const FullType(PhotoSuggestionId),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SuggestedPhotoRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SuggestedPhotoRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'suggestionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PhotoSuggestionId),
          ) as PhotoSuggestionId;
          result.suggestionId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SuggestedPhotoRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SuggestedPhotoRequestBuilder();
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


