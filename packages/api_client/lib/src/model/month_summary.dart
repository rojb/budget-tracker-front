//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'month_summary.g.dart';

/// The figures the budget engine derives for one month.
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [currentMonth] - Current month in the plan's time zone.
/// * [isFuture] - True when the month is after the current month.
/// * [balanceMinor] - Σ balances of the active accounts at the end of the month.
/// * [availableMinor] - Σ Available of every envelope in the month.
/// * [futureAssignedMinor] - Σ Assigned in the months after this one.
/// * [readyToAssignMinor] - Ready to Assign of the month; for a future month, the current month's.
/// * [assignedMinor] - Σ Assigned in the month.
/// * [envelopeCount] 
/// * [overspentCount] 
/// * [underfundedCount] 
/// * [fundedCount] 
@BuiltValue()
abstract class MonthSummary implements Built<MonthSummary, MonthSummaryBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  /// Current month in the plan's time zone.
  @BuiltValueField(wireName: r'currentMonth')
  String get currentMonth;

  /// True when the month is after the current month.
  @BuiltValueField(wireName: r'isFuture')
  bool get isFuture;

  /// Σ balances of the active accounts at the end of the month.
  @BuiltValueField(wireName: r'balanceMinor')
  int get balanceMinor;

  /// Σ Available of every envelope in the month.
  @BuiltValueField(wireName: r'availableMinor')
  int get availableMinor;

  /// Σ Assigned in the months after this one.
  @BuiltValueField(wireName: r'futureAssignedMinor')
  int get futureAssignedMinor;

  /// Ready to Assign of the month; for a future month, the current month's.
  @BuiltValueField(wireName: r'readyToAssignMinor')
  int get readyToAssignMinor;

  /// Σ Assigned in the month.
  @BuiltValueField(wireName: r'assignedMinor')
  int get assignedMinor;

  @BuiltValueField(wireName: r'envelopeCount')
  int get envelopeCount;

  @BuiltValueField(wireName: r'overspentCount')
  int get overspentCount;

  @BuiltValueField(wireName: r'underfundedCount')
  int get underfundedCount;

  @BuiltValueField(wireName: r'fundedCount')
  int get fundedCount;

  MonthSummary._();

  factory MonthSummary([void updates(MonthSummaryBuilder b)]) = _$MonthSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MonthSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MonthSummary> get serializer => _$MonthSummarySerializer();
}

class _$MonthSummarySerializer implements PrimitiveSerializer<MonthSummary> {
  @override
  final Iterable<Type> types = const [MonthSummary, _$MonthSummary];

  @override
  final String wireName = r'MonthSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MonthSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'currentMonth';
    yield serializers.serialize(
      object.currentMonth,
      specifiedType: const FullType(String),
    );
    yield r'isFuture';
    yield serializers.serialize(
      object.isFuture,
      specifiedType: const FullType(bool),
    );
    yield r'balanceMinor';
    yield serializers.serialize(
      object.balanceMinor,
      specifiedType: const FullType(int),
    );
    yield r'availableMinor';
    yield serializers.serialize(
      object.availableMinor,
      specifiedType: const FullType(int),
    );
    yield r'futureAssignedMinor';
    yield serializers.serialize(
      object.futureAssignedMinor,
      specifiedType: const FullType(int),
    );
    yield r'readyToAssignMinor';
    yield serializers.serialize(
      object.readyToAssignMinor,
      specifiedType: const FullType(int),
    );
    yield r'assignedMinor';
    yield serializers.serialize(
      object.assignedMinor,
      specifiedType: const FullType(int),
    );
    yield r'envelopeCount';
    yield serializers.serialize(
      object.envelopeCount,
      specifiedType: const FullType(int),
    );
    yield r'overspentCount';
    yield serializers.serialize(
      object.overspentCount,
      specifiedType: const FullType(int),
    );
    yield r'underfundedCount';
    yield serializers.serialize(
      object.underfundedCount,
      specifiedType: const FullType(int),
    );
    yield r'fundedCount';
    yield serializers.serialize(
      object.fundedCount,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MonthSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MonthSummaryBuilder result,
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
        case r'currentMonth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currentMonth = valueDes;
          break;
        case r'isFuture':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isFuture = valueDes;
          break;
        case r'balanceMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.balanceMinor = valueDes;
          break;
        case r'availableMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.availableMinor = valueDes;
          break;
        case r'futureAssignedMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.futureAssignedMinor = valueDes;
          break;
        case r'readyToAssignMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.readyToAssignMinor = valueDes;
          break;
        case r'assignedMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.assignedMinor = valueDes;
          break;
        case r'envelopeCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.envelopeCount = valueDes;
          break;
        case r'overspentCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.overspentCount = valueDes;
          break;
        case r'underfundedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.underfundedCount = valueDes;
          break;
        case r'fundedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fundedCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MonthSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MonthSummaryBuilder();
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


