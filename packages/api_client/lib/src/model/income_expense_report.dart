//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/income_expense_month.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'income_expense_report.g.dart';

/// IncomeExpenseReport
///
/// Properties:
/// * [from] - Budget month as YYYY-MM.
/// * [to] - Budget month as YYYY-MM.
/// * [months] 
@BuiltValue()
abstract class IncomeExpenseReport implements Built<IncomeExpenseReport, IncomeExpenseReportBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'from')
  String get from;

  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'months')
  BuiltList<IncomeExpenseMonth> get months;

  IncomeExpenseReport._();

  factory IncomeExpenseReport([void updates(IncomeExpenseReportBuilder b)]) = _$IncomeExpenseReport;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IncomeExpenseReportBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IncomeExpenseReport> get serializer => _$IncomeExpenseReportSerializer();
}

class _$IncomeExpenseReportSerializer implements PrimitiveSerializer<IncomeExpenseReport> {
  @override
  final Iterable<Type> types = const [IncomeExpenseReport, _$IncomeExpenseReport];

  @override
  final String wireName = r'IncomeExpenseReport';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IncomeExpenseReport object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(String),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(String),
    );
    yield r'months';
    yield serializers.serialize(
      object.months,
      specifiedType: const FullType(BuiltList, [FullType(IncomeExpenseMonth)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    IncomeExpenseReport object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IncomeExpenseReportBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.to = valueDes;
          break;
        case r'months':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(IncomeExpenseMonth)]),
          ) as BuiltList<IncomeExpenseMonth>;
          result.months.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IncomeExpenseReport deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IncomeExpenseReportBuilder();
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


