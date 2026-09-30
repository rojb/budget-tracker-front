//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_payee_request.g.dart';

/// UpdatePayeeRequest
///
/// Properties:
/// * [name] 
/// * [suggestedEnvelopeId] - UUID v4 identifier.
@BuiltValue()
abstract class UpdatePayeeRequest implements Built<UpdatePayeeRequest, UpdatePayeeRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'suggestedEnvelopeId')
  String? get suggestedEnvelopeId;

  UpdatePayeeRequest._();

  factory UpdatePayeeRequest([void updates(UpdatePayeeRequestBuilder b)]) = _$UpdatePayeeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePayeeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePayeeRequest> get serializer => _$UpdatePayeeRequestSerializer();
}

class _$UpdatePayeeRequestSerializer implements PrimitiveSerializer<UpdatePayeeRequest> {
  @override
  final Iterable<Type> types = const [UpdatePayeeRequest, _$UpdatePayeeRequest];

  @override
  final String wireName = r'UpdatePayeeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePayeeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.suggestedEnvelopeId != null) {
      yield r'suggestedEnvelopeId';
      yield serializers.serialize(
        object.suggestedEnvelopeId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdatePayeeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdatePayeeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'suggestedEnvelopeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.suggestedEnvelopeId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdatePayeeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePayeeRequestBuilder();
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


