//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/envelope_spending.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'spending_month.g.dart';

/// SpendingMonth
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [totalMinor] - Σ of the envelopes' spending in the month.
/// * [envelopes] - Envelopes with spending above zero, largest first.
@BuiltValue()
abstract class SpendingMonth implements Built<SpendingMonth, SpendingMonthBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  /// Σ of the envelopes' spending in the month.
  @BuiltValueField(wireName: r'totalMinor')
  int get totalMinor;

  /// Envelopes with spending above zero, largest first.
  @BuiltValueField(wireName: r'envelopes')
  BuiltList<EnvelopeSpending> get envelopes;

  SpendingMonth._();

  factory SpendingMonth([void updates(SpendingMonthBuilder b)]) = _$SpendingMonth;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SpendingMonthBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SpendingMonth> get serializer => _$SpendingMonthSerializer();
}

class _$SpendingMonthSerializer implements PrimitiveSerializer<SpendingMonth> {
  @override
  final Iterable<Type> types = const [SpendingMonth, _$SpendingMonth];

  @override
  final String wireName = r'SpendingMonth';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SpendingMonth object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'totalMinor';
    yield serializers.serialize(
      object.totalMinor,
      specifiedType: const FullType(int),
    );
    yield r'envelopes';
    yield serializers.serialize(
      object.envelopes,
      specifiedType: const FullType(BuiltList, [FullType(EnvelopeSpending)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SpendingMonth object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SpendingMonthBuilder result,
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
        case r'totalMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalMinor = valueDes;
          break;
        case r'envelopes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EnvelopeSpending)]),
          ) as BuiltList<EnvelopeSpending>;
          result.envelopes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SpendingMonth deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SpendingMonthBuilder();
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


