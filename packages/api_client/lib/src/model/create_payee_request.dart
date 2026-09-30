//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_payee_request.g.dart';

/// CreatePayeeRequest
///
/// Properties:
/// * [name] 
/// * [suggestedEnvelopeId] - UUID v4 identifier.
@BuiltValue()
abstract class CreatePayeeRequest implements Built<CreatePayeeRequest, CreatePayeeRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'suggestedEnvelopeId')
  String? get suggestedEnvelopeId;

  CreatePayeeRequest._();

  factory CreatePayeeRequest([void updates(CreatePayeeRequestBuilder b)]) = _$CreatePayeeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePayeeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePayeeRequest> get serializer => _$CreatePayeeRequestSerializer();
}

class _$CreatePayeeRequestSerializer implements PrimitiveSerializer<CreatePayeeRequest> {
  @override
  final Iterable<Type> types = const [CreatePayeeRequest, _$CreatePayeeRequest];

  @override
  final String wireName = r'CreatePayeeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePayeeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
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
    CreatePayeeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePayeeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  CreatePayeeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePayeeRequestBuilder();
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


