//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/date.dart';
import 'package:api_client/src/model/envelope_goal_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_goal.g.dart';

/// The goal of an envelope. A `monthly` goal takes no `dueDate`; a `targetByDate` goal requires one (a date in the current month or later, in the plan's time zone). 
///
/// Properties:
/// * [type] 
/// * [targetMinor] 
/// * [dueDate] 
@BuiltValue()
abstract class EnvelopeGoal implements Built<EnvelopeGoal, EnvelopeGoalBuilder> {
  @BuiltValueField(wireName: r'type')
  EnvelopeGoalType get type;
  // enum typeEnum {  monthly,  targetByDate,  };

  @BuiltValueField(wireName: r'targetMinor')
  int get targetMinor;

  @BuiltValueField(wireName: r'dueDate')
  Date? get dueDate;

  EnvelopeGoal._();

  factory EnvelopeGoal([void updates(EnvelopeGoalBuilder b)]) = _$EnvelopeGoal;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeGoalBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnvelopeGoal> get serializer => _$EnvelopeGoalSerializer();
}

class _$EnvelopeGoalSerializer implements PrimitiveSerializer<EnvelopeGoal> {
  @override
  final Iterable<Type> types = const [EnvelopeGoal, _$EnvelopeGoal];

  @override
  final String wireName = r'EnvelopeGoal';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnvelopeGoal object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(EnvelopeGoalType),
    );
    yield r'targetMinor';
    yield serializers.serialize(
      object.targetMinor,
      specifiedType: const FullType(int),
    );
    if (object.dueDate != null) {
      yield r'dueDate';
      yield serializers.serialize(
        object.dueDate,
        specifiedType: const FullType(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EnvelopeGoal object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeGoalBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnvelopeGoalType),
          ) as EnvelopeGoalType;
          result.type = valueDes;
          break;
        case r'targetMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.targetMinor = valueDes;
          break;
        case r'dueDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.dueDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EnvelopeGoal deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeGoalBuilder();
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


