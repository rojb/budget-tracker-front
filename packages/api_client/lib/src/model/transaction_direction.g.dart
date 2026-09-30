// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_direction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransactionDirection _$expense = const TransactionDirection._('expense');
const TransactionDirection _$income = const TransactionDirection._('income');

TransactionDirection _$valueOf(String name) {
  switch (name) {
    case 'expense':
      return _$expense;
    case 'income':
      return _$income;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionDirection> _$values =
    BuiltSet<TransactionDirection>(const <TransactionDirection>[
  _$expense,
  _$income,
]);

class _$TransactionDirectionMeta {
  const _$TransactionDirectionMeta();
  TransactionDirection get expense => _$expense;
  TransactionDirection get income => _$income;
  TransactionDirection valueOf(String name) => _$valueOf(name);
  BuiltSet<TransactionDirection> get values => _$values;
}

mixin _$TransactionDirectionMixin {
  // ignore: non_constant_identifier_names
  _$TransactionDirectionMeta get TransactionDirection =>
      const _$TransactionDirectionMeta();
}

Serializer<TransactionDirection> _$transactionDirectionSerializer =
    _$TransactionDirectionSerializer();

class _$TransactionDirectionSerializer
    implements PrimitiveSerializer<TransactionDirection> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'expense': 'expense',
    'income': 'income',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'expense': 'expense',
    'income': 'income',
  };

  @override
  final Iterable<Type> types = const <Type>[TransactionDirection];
  @override
  final String wireName = 'TransactionDirection';

  @override
  Object serialize(Serializers serializers, TransactionDirection object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionDirection deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionDirection.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
