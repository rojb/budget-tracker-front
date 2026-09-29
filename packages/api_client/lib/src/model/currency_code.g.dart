// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_code.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CurrencyCode _$ARS = const CurrencyCode._('ARS');
const CurrencyCode _$USD = const CurrencyCode._('USD');
const CurrencyCode _$EUR = const CurrencyCode._('EUR');

CurrencyCode _$valueOf(String name) {
  switch (name) {
    case 'ARS':
      return _$ARS;
    case 'USD':
      return _$USD;
    case 'EUR':
      return _$EUR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CurrencyCode> _$values =
    BuiltSet<CurrencyCode>(const <CurrencyCode>[
  _$ARS,
  _$USD,
  _$EUR,
]);

class _$CurrencyCodeMeta {
  const _$CurrencyCodeMeta();
  CurrencyCode get ARS => _$ARS;
  CurrencyCode get USD => _$USD;
  CurrencyCode get EUR => _$EUR;
  CurrencyCode valueOf(String name) => _$valueOf(name);
  BuiltSet<CurrencyCode> get values => _$values;
}

mixin _$CurrencyCodeMixin {
  // ignore: non_constant_identifier_names
  _$CurrencyCodeMeta get CurrencyCode => const _$CurrencyCodeMeta();
}

Serializer<CurrencyCode> _$currencyCodeSerializer = _$CurrencyCodeSerializer();

class _$CurrencyCodeSerializer implements PrimitiveSerializer<CurrencyCode> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ARS': 'ARS',
    'USD': 'USD',
    'EUR': 'EUR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ARS': 'ARS',
    'USD': 'USD',
    'EUR': 'EUR',
  };

  @override
  final Iterable<Type> types = const <Type>[CurrencyCode];
  @override
  final String wireName = 'CurrencyCode';

  @override
  Object serialize(Serializers serializers, CurrencyCode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CurrencyCode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CurrencyCode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
