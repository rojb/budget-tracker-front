//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reorder_envelope_groups_request.g.dart';

/// ReorderEnvelopeGroupsRequest
///
/// Properties:
/// * [groupIds] - Every group of the plan exactly once, in the desired order.
@BuiltValue()
abstract class ReorderEnvelopeGroupsRequest implements Built<ReorderEnvelopeGroupsRequest, ReorderEnvelopeGroupsRequestBuilder> {
  /// Every group of the plan exactly once, in the desired order.
  @BuiltValueField(wireName: r'groupIds')
  BuiltList<String> get groupIds;

  ReorderEnvelopeGroupsRequest._();

  factory ReorderEnvelopeGroupsRequest([void updates(ReorderEnvelopeGroupsRequestBuilder b)]) = _$ReorderEnvelopeGroupsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReorderEnvelopeGroupsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReorderEnvelopeGroupsRequest> get serializer => _$ReorderEnvelopeGroupsRequestSerializer();
}

class _$ReorderEnvelopeGroupsRequestSerializer implements PrimitiveSerializer<ReorderEnvelopeGroupsRequest> {
  @override
  final Iterable<Type> types = const [ReorderEnvelopeGroupsRequest, _$ReorderEnvelopeGroupsRequest];

  @override
  final String wireName = r'ReorderEnvelopeGroupsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReorderEnvelopeGroupsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'groupIds';
    yield serializers.serialize(
      object.groupIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReorderEnvelopeGroupsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReorderEnvelopeGroupsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'groupIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.groupIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReorderEnvelopeGroupsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReorderEnvelopeGroupsRequestBuilder();
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


