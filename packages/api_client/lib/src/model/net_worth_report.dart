//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/net_worth_month.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'net_worth_report.g.dart';

/// NetWorthReport
///
/// Properties:
/// * [from] - Budget month as YYYY-MM.
/// * [to] - Budget month as YYYY-MM.
/// * [months] 
@BuiltValue()
abstract class NetWorthReport implements Built<NetWorthReport, NetWorthReportBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'from')
  String get from;

  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'months')
  BuiltList<NetWorthMonth> get months;

  NetWorthReport._();

  factory NetWorthReport([void updates(NetWorthReportBuilder b)]) = _$NetWorthReport;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NetWorthReportBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NetWorthReport> get serializer => _$NetWorthReportSerializer();
}

class _$NetWorthReportSerializer implements PrimitiveSerializer<NetWorthReport> {
  @override
  final Iterable<Type> types = const [NetWorthReport, _$NetWorthReport];

  @override
  final String wireName = r'NetWorthReport';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NetWorthReport object, {
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
      specifiedType: const FullType(BuiltList, [FullType(NetWorthMonth)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NetWorthReport object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NetWorthReportBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(NetWorthMonth)]),
          ) as BuiltList<NetWorthMonth>;
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
  NetWorthReport deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NetWorthReportBuilder();
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


