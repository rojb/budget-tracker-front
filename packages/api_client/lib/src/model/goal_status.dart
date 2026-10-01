//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'goal_status.g.dart';

/// Progress of an envelope's goal in a month, derived from the goal and the budget engine's figures.
///
/// Properties:
/// * [requiredMinor] - Amount to assign in the month to be on track (the target for a monthly goal; the shortfall over the carryover spread over the months left, rounded up, for a goal with a date).
/// * [missingMinor] - What the month still needs, `max(0, required - assigned)`.
/// * [savedMinor] - Assigned of the month for a monthly goal; Available (floored at 0) for a goal with a date.
/// * [remainingMinor] - `max(0, target - saved)`.
/// * [percent] - Saved over target, floored and capped at 100.
/// * [monthsRemaining] - Months from the viewed month to the due month; only for a goal with a date, 0 in the due month and after it.
@BuiltValue()
abstract class GoalStatus implements Built<GoalStatus, GoalStatusBuilder> {
  /// Amount to assign in the month to be on track (the target for a monthly goal; the shortfall over the carryover spread over the months left, rounded up, for a goal with a date).
  @BuiltValueField(wireName: r'requiredMinor')
  int get requiredMinor;

  /// What the month still needs, `max(0, required - assigned)`.
  @BuiltValueField(wireName: r'missingMinor')
  int get missingMinor;

  /// Assigned of the month for a monthly goal; Available (floored at 0) for a goal with a date.
  @BuiltValueField(wireName: r'savedMinor')
  int get savedMinor;

  /// `max(0, target - saved)`.
  @BuiltValueField(wireName: r'remainingMinor')
  int get remainingMinor;

  /// Saved over target, floored and capped at 100.
  @BuiltValueField(wireName: r'percent')
  int get percent;

  /// Months from the viewed month to the due month; only for a goal with a date, 0 in the due month and after it.
  @BuiltValueField(wireName: r'monthsRemaining')
  int? get monthsRemaining;

  GoalStatus._();

  factory GoalStatus([void updates(GoalStatusBuilder b)]) = _$GoalStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GoalStatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GoalStatus> get serializer => _$GoalStatusSerializer();
}

class _$GoalStatusSerializer implements PrimitiveSerializer<GoalStatus> {
  @override
  final Iterable<Type> types = const [GoalStatus, _$GoalStatus];

  @override
  final String wireName = r'GoalStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GoalStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'requiredMinor';
    yield serializers.serialize(
      object.requiredMinor,
      specifiedType: const FullType(int),
    );
    yield r'missingMinor';
    yield serializers.serialize(
      object.missingMinor,
      specifiedType: const FullType(int),
    );
    yield r'savedMinor';
    yield serializers.serialize(
      object.savedMinor,
      specifiedType: const FullType(int),
    );
    yield r'remainingMinor';
    yield serializers.serialize(
      object.remainingMinor,
      specifiedType: const FullType(int),
    );
    yield r'percent';
    yield serializers.serialize(
      object.percent,
      specifiedType: const FullType(int),
    );
    if (object.monthsRemaining != null) {
      yield r'monthsRemaining';
      yield serializers.serialize(
        object.monthsRemaining,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GoalStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GoalStatusBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'requiredMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requiredMinor = valueDes;
          break;
        case r'missingMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.missingMinor = valueDes;
          break;
        case r'savedMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.savedMinor = valueDes;
          break;
        case r'remainingMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.remainingMinor = valueDes;
          break;
        case r'percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.percent = valueDes;
          break;
        case r'monthsRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.monthsRemaining = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GoalStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GoalStatusBuilder();
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


