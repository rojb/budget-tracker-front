//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_direction.g.dart';

/// `expense` moves money out of the account, `income` moves money in.
class TransactionDirection extends EnumClass {

  @BuiltValueEnumConst(wireName: r'expense')
  static const TransactionDirection expense = _$expense;
  @BuiltValueEnumConst(wireName: r'income')
  static const TransactionDirection income = _$income;

  static Serializer<TransactionDirection> get serializer => _$transactionDirectionSerializer;

  const TransactionDirection._(String name): super(name);

  static BuiltSet<TransactionDirection> get values => _$values;
  static TransactionDirection valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransactionDirectionMixin = Object with _$TransactionDirectionMixin;

