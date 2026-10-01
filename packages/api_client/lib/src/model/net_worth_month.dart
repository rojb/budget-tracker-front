//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'net_worth_month.g.dart';

/// NetWorthMonth
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [balanceMinor] - Σ balances of the active accounts at the end of the month.
@BuiltValue()
abstract class NetWorthMonth implements Built<NetWorthMonth, NetWorthMonthBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  /// Σ balances of the active accounts at the end of the month.
  @BuiltValueField(wireName: r'balanceMinor')
  int get balanceMinor;

  NetWorthMonth._();

  factory NetWorthMonth([void updates(NetWorthMonthBuilder b)]) = _$NetWorthMonth;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NetWorthMonthBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NetWorthMonth> get serializer => _$NetWorthMonthSerializer();
}

class _$NetWorthMonthSerializer implements PrimitiveSerializer<NetWorthMonth> {
  @override
  final Iterable<Type> types = const [NetWorthMonth, _$NetWorthMonth];

  @override
  final String wireName = r'NetWorthMonth';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NetWorthMonth object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'balanceMinor';
    yield serializers.serialize(
      object.balanceMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NetWorthMonth object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NetWorthMonthBuilder result,
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
        case r'balanceMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.balanceMinor = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NetWorthMonth deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NetWorthMonthBuilder();
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


