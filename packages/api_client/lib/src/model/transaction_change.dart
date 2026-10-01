//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/affected_months.dart';
import 'package:api_client/src/model/transaction.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_change.g.dart';

/// TransactionChange
///
/// Properties:
/// * [affectedMonths] 
/// * [transaction] 
@BuiltValue()
abstract class TransactionChange implements AffectedMonths, Built<TransactionChange, TransactionChangeBuilder> {
  @BuiltValueField(wireName: r'transaction')
  Transaction get transaction;

  TransactionChange._();

  factory TransactionChange([void updates(TransactionChangeBuilder b)]) = _$TransactionChange;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionChangeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionChange> get serializer => _$TransactionChangeSerializer();
}

class _$TransactionChangeSerializer implements PrimitiveSerializer<TransactionChange> {
  @override
  final Iterable<Type> types = const [TransactionChange, _$TransactionChange];

  @override
  final String wireName = r'TransactionChange';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionChange object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'transaction';
    yield serializers.serialize(
      object.transaction,
      specifiedType: const FullType(Transaction),
    );
    yield r'affectedMonths';
    yield serializers.serialize(
      object.affectedMonths,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionChange object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionChangeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'transaction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Transaction),
          ) as Transaction;
          result.transaction.replace(valueDes);
          break;
        case r'affectedMonths':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.affectedMonths.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionChange deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionChangeBuilder();
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


