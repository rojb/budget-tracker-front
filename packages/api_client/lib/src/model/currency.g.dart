// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CurrencySymbolEnum _$currencySymbolEnum_dollar =
    const CurrencySymbolEnum._('dollar');
const CurrencySymbolEnum _$currencySymbolEnum_uSDollar =
    const CurrencySymbolEnum._('uSDollar');
const CurrencySymbolEnum _$currencySymbolEnum_euro =
    const CurrencySymbolEnum._('euro');

CurrencySymbolEnum _$currencySymbolEnumValueOf(String name) {
  switch (name) {
    case 'dollar':
      return _$currencySymbolEnum_dollar;
    case 'uSDollar':
      return _$currencySymbolEnum_uSDollar;
    case 'euro':
      return _$currencySymbolEnum_euro;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CurrencySymbolEnum> _$currencySymbolEnumValues =
    BuiltSet<CurrencySymbolEnum>(const <CurrencySymbolEnum>[
  _$currencySymbolEnum_dollar,
  _$currencySymbolEnum_uSDollar,
  _$currencySymbolEnum_euro,
]);

const CurrencyNameEnum _$currencyNameEnum_pesos =
    const CurrencyNameEnum._('pesos');
const CurrencyNameEnum _$currencyNameEnum_dlares =
    const CurrencyNameEnum._('dlares');
const CurrencyNameEnum _$currencyNameEnum_euros =
    const CurrencyNameEnum._('euros');

CurrencyNameEnum _$currencyNameEnumValueOf(String name) {
  switch (name) {
    case 'pesos':
      return _$currencyNameEnum_pesos;
    case 'dlares':
      return _$currencyNameEnum_dlares;
    case 'euros':
      return _$currencyNameEnum_euros;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CurrencyNameEnum> _$currencyNameEnumValues =
    BuiltSet<CurrencyNameEnum>(const <CurrencyNameEnum>[
  _$currencyNameEnum_pesos,
  _$currencyNameEnum_dlares,
  _$currencyNameEnum_euros,
]);

const CurrencyMinorUnitsEnum _$currencyMinorUnitsEnum_number0 =
    const CurrencyMinorUnitsEnum._('number0');
const CurrencyMinorUnitsEnum _$currencyMinorUnitsEnum_number2 =
    const CurrencyMinorUnitsEnum._('number2');

CurrencyMinorUnitsEnum _$currencyMinorUnitsEnumValueOf(String name) {
  switch (name) {
    case 'number0':
      return _$currencyMinorUnitsEnum_number0;
    case 'number2':
      return _$currencyMinorUnitsEnum_number2;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CurrencyMinorUnitsEnum> _$currencyMinorUnitsEnumValues =
    BuiltSet<CurrencyMinorUnitsEnum>(const <CurrencyMinorUnitsEnum>[
  _$currencyMinorUnitsEnum_number0,
  _$currencyMinorUnitsEnum_number2,
]);

Serializer<CurrencySymbolEnum> _$currencySymbolEnumSerializer =
    _$CurrencySymbolEnumSerializer();
Serializer<CurrencyNameEnum> _$currencyNameEnumSerializer =
    _$CurrencyNameEnumSerializer();
Serializer<CurrencyMinorUnitsEnum> _$currencyMinorUnitsEnumSerializer =
    _$CurrencyMinorUnitsEnumSerializer();

class _$CurrencySymbolEnumSerializer
    implements PrimitiveSerializer<CurrencySymbolEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'dollar': '\$',
    'uSDollar': 'US\$',
    'euro': '€',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '\$': 'dollar',
    'US\$': 'uSDollar',
    '€': 'euro',
  };

  @override
  final Iterable<Type> types = const <Type>[CurrencySymbolEnum];
  @override
  final String wireName = 'CurrencySymbolEnum';

  @override
  Object serialize(Serializers serializers, CurrencySymbolEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CurrencySymbolEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CurrencySymbolEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CurrencyNameEnumSerializer
    implements PrimitiveSerializer<CurrencyNameEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pesos': 'pesos',
    'dlares': 'dólares',
    'euros': 'euros',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pesos': 'pesos',
    'dólares': 'dlares',
    'euros': 'euros',
  };

  @override
  final Iterable<Type> types = const <Type>[CurrencyNameEnum];
  @override
  final String wireName = 'CurrencyNameEnum';

  @override
  Object serialize(Serializers serializers, CurrencyNameEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CurrencyNameEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CurrencyNameEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CurrencyMinorUnitsEnumSerializer
    implements PrimitiveSerializer<CurrencyMinorUnitsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number0': 0,
    'number2': 2,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    0: 'number0',
    2: 'number2',
  };

  @override
  final Iterable<Type> types = const <Type>[CurrencyMinorUnitsEnum];
  @override
  final String wireName = 'CurrencyMinorUnitsEnum';

  @override
  Object serialize(Serializers serializers, CurrencyMinorUnitsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CurrencyMinorUnitsEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CurrencyMinorUnitsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Currency extends Currency {
  @override
  final CurrencyCode code;
  @override
  final CurrencySymbolEnum symbol;
  @override
  final CurrencyNameEnum name;
  @override
  final CurrencyMinorUnitsEnum minorUnits;

  factory _$Currency([void Function(CurrencyBuilder)? updates]) =>
      (CurrencyBuilder()..update(updates))._build();

  _$Currency._(
      {required this.code,
      required this.symbol,
      required this.name,
      required this.minorUnits})
      : super._();
  @override
  Currency rebuild(void Function(CurrencyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyBuilder toBuilder() => CurrencyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Currency &&
        code == other.code &&
        symbol == other.symbol &&
        name == other.name &&
        minorUnits == other.minorUnits;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, minorUnits.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Currency')
          ..add('code', code)
          ..add('symbol', symbol)
          ..add('name', name)
          ..add('minorUnits', minorUnits))
        .toString();
  }
}

class CurrencyBuilder implements Builder<Currency, CurrencyBuilder> {
  _$Currency? _$v;

  CurrencyCode? _code;
  CurrencyCode? get code => _$this._code;
  set code(CurrencyCode? code) => _$this._code = code;

  CurrencySymbolEnum? _symbol;
  CurrencySymbolEnum? get symbol => _$this._symbol;
  set symbol(CurrencySymbolEnum? symbol) => _$this._symbol = symbol;

  CurrencyNameEnum? _name;
  CurrencyNameEnum? get name => _$this._name;
  set name(CurrencyNameEnum? name) => _$this._name = name;

  CurrencyMinorUnitsEnum? _minorUnits;
  CurrencyMinorUnitsEnum? get minorUnits => _$this._minorUnits;
  set minorUnits(CurrencyMinorUnitsEnum? minorUnits) =>
      _$this._minorUnits = minorUnits;

  CurrencyBuilder() {
    Currency._defaults(this);
  }

  CurrencyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _symbol = $v.symbol;
      _name = $v.name;
      _minorUnits = $v.minorUnits;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Currency other) {
    _$v = other as _$Currency;
  }

  @override
  void update(void Function(CurrencyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Currency build() => _build();

  _$Currency _build() {
    final _$result = _$v ??
        _$Currency._(
          code:
              BuiltValueNullFieldError.checkNotNull(code, r'Currency', 'code'),
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'Currency', 'symbol'),
          name:
              BuiltValueNullFieldError.checkNotNull(name, r'Currency', 'name'),
          minorUnits: BuiltValueNullFieldError.checkNotNull(
              minorUnits, r'Currency', 'minorUnits'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
