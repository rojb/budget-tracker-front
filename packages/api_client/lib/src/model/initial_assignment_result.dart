//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'initial_assignment_result.g.dart';

/// InitialAssignmentResult
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [assignedMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD, EUR and BOB are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [readyToAssignMinor] - Ready to Assign of the month after the assignment; negative when over-assigned.
@BuiltValue()
abstract class InitialAssignmentResult implements Built<InitialAssignmentResult, InitialAssignmentResultBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD, EUR and BOB are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'assignedMinor')
  int get assignedMinor;

  /// Ready to Assign of the month after the assignment; negative when over-assigned.
  @BuiltValueField(wireName: r'readyToAssignMinor')
  int get readyToAssignMinor;

  InitialAssignmentResult._();

  factory InitialAssignmentResult([void updates(InitialAssignmentResultBuilder b)]) = _$InitialAssignmentResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InitialAssignmentResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InitialAssignmentResult> get serializer => _$InitialAssignmentResultSerializer();
}

class _$InitialAssignmentResultSerializer implements PrimitiveSerializer<InitialAssignmentResult> {
  @override
  final Iterable<Type> types = const [InitialAssignmentResult, _$InitialAssignmentResult];

  @override
  final String wireName = r'InitialAssignmentResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InitialAssignmentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'assignedMinor';
    yield serializers.serialize(
      object.assignedMinor,
      specifiedType: const FullType(int),
    );
    yield r'readyToAssignMinor';
    yield serializers.serialize(
      object.readyToAssignMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InitialAssignmentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InitialAssignmentResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.month = valueDes;
          break;
        case r'assignedMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.assignedMinor = valueDes;
          break;
        case r'readyToAssignMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.readyToAssignMinor = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InitialAssignmentResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InitialAssignmentResultBuilder();
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


