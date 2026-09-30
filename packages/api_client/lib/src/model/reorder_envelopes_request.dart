//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reorder_envelopes_request.g.dart';

/// ReorderEnvelopesRequest
///
/// Properties:
/// * [groupId] - The group whose envelopes are ordered; absent for the envelopes without a group.
/// * [envelopeIds] - Every envelope of that scope exactly once, in the desired order.
@BuiltValue()
abstract class ReorderEnvelopesRequest implements Built<ReorderEnvelopesRequest, ReorderEnvelopesRequestBuilder> {
  /// The group whose envelopes are ordered; absent for the envelopes without a group.
  @BuiltValueField(wireName: r'groupId')
  String? get groupId;

  /// Every envelope of that scope exactly once, in the desired order.
  @BuiltValueField(wireName: r'envelopeIds')
  BuiltList<String> get envelopeIds;

  ReorderEnvelopesRequest._();

  factory ReorderEnvelopesRequest([void updates(ReorderEnvelopesRequestBuilder b)]) = _$ReorderEnvelopesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReorderEnvelopesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReorderEnvelopesRequest> get serializer => _$ReorderEnvelopesRequestSerializer();
}

class _$ReorderEnvelopesRequestSerializer implements PrimitiveSerializer<ReorderEnvelopesRequest> {
  @override
  final Iterable<Type> types = const [ReorderEnvelopesRequest, _$ReorderEnvelopesRequest];

  @override
  final String wireName = r'ReorderEnvelopesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReorderEnvelopesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.groupId != null) {
      yield r'groupId';
      yield serializers.serialize(
        object.groupId,
        specifiedType: const FullType(String),
      );
    }
    yield r'envelopeIds';
    yield serializers.serialize(
      object.envelopeIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReorderEnvelopesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReorderEnvelopesRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'groupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.groupId = valueDes;
          break;
        case r'envelopeIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.envelopeIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReorderEnvelopesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReorderEnvelopesRequestBuilder();
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


