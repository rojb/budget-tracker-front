//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'initial_assignment.g.dart';

/// InitialAssignment
///
/// Properties:
/// * [envelopeId] - UUID v4 identifier.
/// * [amountMinor] 
@BuiltValue()
abstract class InitialAssignment implements Built<InitialAssignment, InitialAssignmentBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'envelopeId')
  String get envelopeId;

  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  InitialAssignment._();

  factory InitialAssignment([void updates(InitialAssignmentBuilder b)]) = _$InitialAssignment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InitialAssignmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InitialAssignment> get serializer => _$InitialAssignmentSerializer();
}

class _$InitialAssignmentSerializer implements PrimitiveSerializer<InitialAssignment> {
  @override
  final Iterable<Type> types = const [InitialAssignment, _$InitialAssignment];

  @override
  final String wireName = r'InitialAssignment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InitialAssignment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'envelopeId';
    yield serializers.serialize(
      object.envelopeId,
      specifiedType: const FullType(String),
    );
    yield r'amountMinor';
    yield serializers.serialize(
      object.amountMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InitialAssignment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InitialAssignmentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'envelopeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.envelopeId = valueDes;
          break;
        case r'amountMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amountMinor = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InitialAssignment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InitialAssignmentBuilder();
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


