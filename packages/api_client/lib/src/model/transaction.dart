//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/transaction_direction.dart';
import 'package:api_client/src/model/transaction_split.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction.g.dart';

/// An expense or income of a plan. Its portions always add up to `amountMinor`.
///
/// Properties:
/// * [id] - UUID v4 identifier.
/// * [direction] 
/// * [accountId] - UUID v4 identifier.
/// * [accountName] 
/// * [amountMinor] - Positive amount in the plan currency's minor units.
/// * [occurredAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
/// * [payeeId] - UUID v4 identifier.
/// * [payeeName] - Name of the payee, also when it was deleted afterwards.
/// * [description] 
/// * [splits] 
/// * [createdAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
@BuiltValue()
abstract class Transaction implements Built<Transaction, TransactionBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'direction')
  TransactionDirection get direction;
  // enum directionEnum {  expense,  income,  };

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'accountId')
  String get accountId;

  @BuiltValueField(wireName: r'accountName')
  String get accountName;

  /// Positive amount in the plan currency's minor units.
  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'occurredAt')
  DateTime get occurredAt;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'payeeId')
  String? get payeeId;

  /// Name of the payee, also when it was deleted afterwards.
  @BuiltValueField(wireName: r'payeeName')
  String? get payeeName;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'splits')
  BuiltList<TransactionSplit> get splits;

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  Transaction._();

  factory Transaction([void updates(TransactionBuilder b)]) = _$Transaction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Transaction> get serializer => _$TransactionSerializer();
}

class _$TransactionSerializer implements PrimitiveSerializer<Transaction> {
  @override
  final Iterable<Type> types = const [Transaction, _$Transaction];

  @override
  final String wireName = r'Transaction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Transaction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'direction';
    yield serializers.serialize(
      object.direction,
      specifiedType: const FullType(TransactionDirection),
    );
    yield r'accountId';
    yield serializers.serialize(
      object.accountId,
      specifiedType: const FullType(String),
    );
    yield r'accountName';
    yield serializers.serialize(
      object.accountName,
      specifiedType: const FullType(String),
    );
    yield r'amountMinor';
    yield serializers.serialize(
      object.amountMinor,
      specifiedType: const FullType(int),
    );
    yield r'occurredAt';
    yield serializers.serialize(
      object.occurredAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.payeeId != null) {
      yield r'payeeId';
      yield serializers.serialize(
        object.payeeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.payeeName != null) {
      yield r'payeeName';
      yield serializers.serialize(
        object.payeeName,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    yield r'splits';
    yield serializers.serialize(
      object.splits,
      specifiedType: const FullType(BuiltList, [FullType(TransactionSplit)]),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Transaction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'direction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionDirection),
          ) as TransactionDirection;
          result.direction = valueDes;
          break;
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountId = valueDes;
          break;
        case r'accountName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountName = valueDes;
          break;
        case r'amountMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amountMinor = valueDes;
          break;
        case r'occurredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        case r'payeeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.payeeId = valueDes;
          break;
        case r'payeeName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.payeeName = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'splits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TransactionSplit)]),
          ) as BuiltList<TransactionSplit>;
          result.splits.replace(valueDes);
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Transaction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionBuilder();
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


