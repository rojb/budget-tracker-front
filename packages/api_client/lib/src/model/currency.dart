//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/currency_code.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'currency.g.dart';

/// Currency of a plan, one of exactly three options. ARS: symbol `$`, name `pesos`, 0 minor units. USD: symbol `US$`, name `dólares`, 2 minor units. EUR: symbol `€`, name `euros`, 2 minor units. Clients format amounts (es-AR: `.` thousands, `,` decimal, `−` before the symbol for negatives); the API never returns pre-formatted money strings. 
///
/// Properties:
/// * [code] 
/// * [symbol] 
/// * [name] - Spanish display name shown next to the symbol, e.g. \"pesos ($)\".
/// * [minorUnits] - Decimal digits of the minor unit.
@BuiltValue()
abstract class Currency implements Built<Currency, CurrencyBuilder> {
  @BuiltValueField(wireName: r'code')
  CurrencyCode get code;
  // enum codeEnum {  ARS,  USD,  EUR,  };

  @BuiltValueField(wireName: r'symbol')
  CurrencySymbolEnum get symbol;
  // enum symbolEnum {  $,  US$,  €,  };

  /// Spanish display name shown next to the symbol, e.g. \"pesos ($)\".
  @BuiltValueField(wireName: r'name')
  CurrencyNameEnum get name;
  // enum nameEnum {  pesos,  dólares,  euros,  };

  /// Decimal digits of the minor unit.
  @BuiltValueField(wireName: r'minorUnits')
  CurrencyMinorUnitsEnum get minorUnits;
  // enum minorUnitsEnum {  0,  2,  };

  Currency._();

  factory Currency([void updates(CurrencyBuilder b)]) = _$Currency;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CurrencyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Currency> get serializer => _$CurrencySerializer();
}

class _$CurrencySerializer implements PrimitiveSerializer<Currency> {
  @override
  final Iterable<Type> types = const [Currency, _$Currency];

  @override
  final String wireName = r'Currency';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Currency object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(CurrencyCode),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(CurrencySymbolEnum),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(CurrencyNameEnum),
    );
    yield r'minorUnits';
    yield serializers.serialize(
      object.minorUnits,
      specifiedType: const FullType(CurrencyMinorUnitsEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Currency object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CurrencyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CurrencyCode),
          ) as CurrencyCode;
          result.code = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CurrencySymbolEnum),
          ) as CurrencySymbolEnum;
          result.symbol = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CurrencyNameEnum),
          ) as CurrencyNameEnum;
          result.name = valueDes;
          break;
        case r'minorUnits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CurrencyMinorUnitsEnum),
          ) as CurrencyMinorUnitsEnum;
          result.minorUnits = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Currency deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CurrencyBuilder();
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


class CurrencySymbolEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'$')
  static const CurrencySymbolEnum dollar = _$currencySymbolEnum_dollar;
  @BuiltValueEnumConst(wireName: r'US$')
  static const CurrencySymbolEnum uSDollar = _$currencySymbolEnum_uSDollar;
  @BuiltValueEnumConst(wireName: r'€')
  static const CurrencySymbolEnum euro = _$currencySymbolEnum_euro;

  static Serializer<CurrencySymbolEnum> get serializer => _$currencySymbolEnumSerializer;

  const CurrencySymbolEnum._(String name): super(name);

  static BuiltSet<CurrencySymbolEnum> get values => _$currencySymbolEnumValues;
  static CurrencySymbolEnum valueOf(String name) => _$currencySymbolEnumValueOf(name);
}

/// Spanish display name shown next to the symbol, e.g. \"pesos ($)\".
class CurrencyNameEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pesos')
  static const CurrencyNameEnum pesos = _$currencyNameEnum_pesos;
  @BuiltValueEnumConst(wireName: r'dólares')
  static const CurrencyNameEnum dlares = _$currencyNameEnum_dlares;
  @BuiltValueEnumConst(wireName: r'euros')
  static const CurrencyNameEnum euros = _$currencyNameEnum_euros;

  static Serializer<CurrencyNameEnum> get serializer => _$currencyNameEnumSerializer;

  const CurrencyNameEnum._(String name): super(name);

  static BuiltSet<CurrencyNameEnum> get values => _$currencyNameEnumValues;
  static CurrencyNameEnum valueOf(String name) => _$currencyNameEnumValueOf(name);
}

/// Decimal digits of the minor unit.
class CurrencyMinorUnitsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 0)
  static const CurrencyMinorUnitsEnum number0 = _$currencyMinorUnitsEnum_number0;
  @BuiltValueEnumConst(wireNumber: 2)
  static const CurrencyMinorUnitsEnum number2 = _$currencyMinorUnitsEnum_number2;

  static Serializer<CurrencyMinorUnitsEnum> get serializer => _$currencyMinorUnitsEnumSerializer;

  const CurrencyMinorUnitsEnum._(String name): super(name);

  static BuiltSet<CurrencyMinorUnitsEnum> get values => _$currencyMinorUnitsEnumValues;
  static CurrencyMinorUnitsEnum valueOf(String name) => _$currencyMinorUnitsEnumValueOf(name);
}

