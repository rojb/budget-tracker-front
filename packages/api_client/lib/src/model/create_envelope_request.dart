//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope_icon.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_envelope_request.g.dart';

/// CreateEnvelopeRequest
///
/// Properties:
/// * [name] 
/// * [groupId] - UUID v4 identifier.
/// * [icon] 
@BuiltValue()
abstract class CreateEnvelopeRequest implements Built<CreateEnvelopeRequest, CreateEnvelopeRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'groupId')
  String? get groupId;

  @BuiltValueField(wireName: r'icon')
  EnvelopeIcon? get icon;
  // enum iconEnum {  tag,  home,  bus,  utensils,  heartPulse,  gift,  cart,  pill,  wifi,  settings,  ticket,  repeat,  lifeBuoy,  plane,  };

  CreateEnvelopeRequest._();

  factory CreateEnvelopeRequest([void updates(CreateEnvelopeRequestBuilder b)]) = _$CreateEnvelopeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateEnvelopeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateEnvelopeRequest> get serializer => _$CreateEnvelopeRequestSerializer();
}

class _$CreateEnvelopeRequestSerializer implements PrimitiveSerializer<CreateEnvelopeRequest> {
  @override
  final Iterable<Type> types = const [CreateEnvelopeRequest, _$CreateEnvelopeRequest];

  @override
  final String wireName = r'CreateEnvelopeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateEnvelopeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.groupId != null) {
      yield r'groupId';
      yield serializers.serialize(
        object.groupId,
        specifiedType: const FullType(String),
      );
    }
    if (object.icon != null) {
      yield r'icon';
      yield serializers.serialize(
        object.icon,
        specifiedType: const FullType(EnvelopeIcon),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateEnvelopeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateEnvelopeRequestBuilder result,
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
        case r'groupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.groupId = valueDes;
          break;
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(EnvelopeIcon),
          ) as EnvelopeIcon?;
          if (valueDes == null) continue;
          result.icon = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateEnvelopeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateEnvelopeRequestBuilder();
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


