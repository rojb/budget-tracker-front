//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/initial_assignment.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'initial_assignment_request.g.dart';

/// InitialAssignmentRequest
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [assignments] 
@BuiltValue()
abstract class InitialAssignmentRequest implements Built<InitialAssignmentRequest, InitialAssignmentRequestBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String? get month;

  @BuiltValueField(wireName: r'assignments')
  BuiltList<InitialAssignment> get assignments;

  InitialAssignmentRequest._();

  factory InitialAssignmentRequest([void updates(InitialAssignmentRequestBuilder b)]) = _$InitialAssignmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InitialAssignmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InitialAssignmentRequest> get serializer => _$InitialAssignmentRequestSerializer();
}

class _$InitialAssignmentRequestSerializer implements PrimitiveSerializer<InitialAssignmentRequest> {
  @override
  final Iterable<Type> types = const [InitialAssignmentRequest, _$InitialAssignmentRequest];

  @override
  final String wireName = r'InitialAssignmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InitialAssignmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.month != null) {
      yield r'month';
      yield serializers.serialize(
        object.month,
        specifiedType: const FullType(String),
      );
    }
    yield r'assignments';
    yield serializers.serialize(
      object.assignments,
      specifiedType: const FullType(BuiltList, [FullType(InitialAssignment)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InitialAssignmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InitialAssignmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.month = valueDes;
          break;
        case r'assignments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(InitialAssignment)]),
          ) as BuiltList<InitialAssignment>;
          result.assignments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InitialAssignmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InitialAssignmentRequestBuilder();
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


