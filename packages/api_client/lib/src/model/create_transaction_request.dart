//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/transaction_direction.dart';
import 'package:api_client/src/model/create_transaction_split.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_transaction_request.g.dart';

/// Exclusive fields, enforced with `400`: `payeeId` or `payeeName`; for an expense `envelopeId` or `splits` (one of them is required); an income takes no `splits`. The portions of `splits` must add up exactly to `amountMinor`. 
///
/// Properties:
/// * [direction] 
/// * [accountId] - UUID v4 identifier.
/// * [amountMinor] 
/// * [occurredAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
/// * [payeeId] - UUID v4 identifier.
/// * [payeeName] 
/// * [description] 
/// * [envelopeId] - UUID v4 identifier.
/// * [splits] 
@BuiltValue()
abstract class CreateTransactionRequest implements Built<CreateTransactionRequest, CreateTransactionRequestBuilder> {
  @BuiltValueField(wireName: r'direction')
  TransactionDirection get direction;
  // enum directionEnum {  expense,  income,  };

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'accountId')
  String get accountId;

  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'occurredAt')
  DateTime get occurredAt;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'payeeId')
  String? get payeeId;

  @BuiltValueField(wireName: r'payeeName')
  String? get payeeName;

  @BuiltValueField(wireName: r'description')
  String? get description;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'envelopeId')
  String? get envelopeId;

  @BuiltValueField(wireName: r'splits')
  BuiltList<CreateTransactionSplit>? get splits;

  CreateTransactionRequest._();

  factory CreateTransactionRequest([void updates(CreateTransactionRequestBuilder b)]) = _$CreateTransactionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateTransactionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateTransactionRequest> get serializer => _$CreateTransactionRequestSerializer();
}

class _$CreateTransactionRequestSerializer implements PrimitiveSerializer<CreateTransactionRequest> {
  @override
  final Iterable<Type> types = const [CreateTransactionRequest, _$CreateTransactionRequest];

  @override
  final String wireName = r'CreateTransactionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateTransactionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.envelopeId != null) {
      yield r'envelopeId';
      yield serializers.serialize(
        object.envelopeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.splits != null) {
      yield r'splits';
      yield serializers.serialize(
        object.splits,
        specifiedType: const FullType(BuiltList, [FullType(CreateTransactionSplit)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateTransactionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateTransactionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'envelopeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.envelopeId = valueDes;
          break;
        case r'splits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(CreateTransactionSplit)]),
          ) as BuiltList<CreateTransactionSplit>?;
          if (valueDes == null) continue;
          result.splits.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateTransactionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateTransactionRequestBuilder();
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


