//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'income_expense_month.g.dart';

/// IncomeExpenseMonth
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [incomeMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [expenseMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
@BuiltValue()
abstract class IncomeExpenseMonth implements Built<IncomeExpenseMonth, IncomeExpenseMonthBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'incomeMinor')
  int get incomeMinor;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'expenseMinor')
  int get expenseMinor;

  IncomeExpenseMonth._();

  factory IncomeExpenseMonth([void updates(IncomeExpenseMonthBuilder b)]) = _$IncomeExpenseMonth;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IncomeExpenseMonthBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IncomeExpenseMonth> get serializer => _$IncomeExpenseMonthSerializer();
}

class _$IncomeExpenseMonthSerializer implements PrimitiveSerializer<IncomeExpenseMonth> {
  @override
  final Iterable<Type> types = const [IncomeExpenseMonth, _$IncomeExpenseMonth];

  @override
  final String wireName = r'IncomeExpenseMonth';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IncomeExpenseMonth object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'incomeMinor';
    yield serializers.serialize(
      object.incomeMinor,
      specifiedType: const FullType(int),
    );
    yield r'expenseMinor';
    yield serializers.serialize(
      object.expenseMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    IncomeExpenseMonth object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IncomeExpenseMonthBuilder result,
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
        case r'incomeMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.incomeMinor = valueDes;
          break;
        case r'expenseMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expenseMinor = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IncomeExpenseMonth deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IncomeExpenseMonthBuilder();
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


