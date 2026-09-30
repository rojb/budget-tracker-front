// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountType _$bank = const AccountType._('bank');
const AccountType _$digitalWallet = const AccountType._('digitalWallet');
const AccountType _$cash = const AccountType._('cash');

AccountType _$valueOf(String name) {
  switch (name) {
    case 'bank':
      return _$bank;
    case 'digitalWallet':
      return _$digitalWallet;
    case 'cash':
      return _$cash;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountType> _$values =
    BuiltSet<AccountType>(const <AccountType>[
  _$bank,
  _$digitalWallet,
  _$cash,
]);

class _$AccountTypeMeta {
  const _$AccountTypeMeta();
  AccountType get bank => _$bank;
  AccountType get digitalWallet => _$digitalWallet;
  AccountType get cash => _$cash;
  AccountType valueOf(String name) => _$valueOf(name);
  BuiltSet<AccountType> get values => _$values;
}

mixin _$AccountTypeMixin {
  // ignore: non_constant_identifier_names
  _$AccountTypeMeta get AccountType => const _$AccountTypeMeta();
}

Serializer<AccountType> _$accountTypeSerializer = _$AccountTypeSerializer();

class _$AccountTypeSerializer implements PrimitiveSerializer<AccountType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bank': 'bank',
    'digitalWallet': 'digitalWallet',
    'cash': 'cash',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bank': 'bank',
    'digitalWallet': 'digitalWallet',
    'cash': 'cash',
  };

  @override
  final Iterable<Type> types = const <Type>[AccountType];
  @override
  final String wireName = 'AccountType';

  @override
  Object serialize(Serializers serializers, AccountType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccountType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccountType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
