//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/spending_month.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'spending_report.g.dart';

/// SpendingReport
///
/// Properties:
/// * [from] - Budget month as YYYY-MM.
/// * [to] - Budget month as YYYY-MM.
/// * [months] 
@BuiltValue()
abstract class SpendingReport implements Built<SpendingReport, SpendingReportBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'from')
  String get from;

  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'months')
  BuiltList<SpendingMonth> get months;

  SpendingReport._();

  factory SpendingReport([void updates(SpendingReportBuilder b)]) = _$SpendingReport;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SpendingReportBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SpendingReport> get serializer => _$SpendingReportSerializer();
}

class _$SpendingReportSerializer implements PrimitiveSerializer<SpendingReport> {
  @override
  final Iterable<Type> types = const [SpendingReport, _$SpendingReport];

  @override
  final String wireName = r'SpendingReport';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SpendingReport object, {
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
      specifiedType: const FullType(BuiltList, [FullType(SpendingMonth)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SpendingReport object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SpendingReportBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(SpendingMonth)]),
          ) as BuiltList<SpendingMonth>;
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
  SpendingReport deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SpendingReportBuilder();
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


