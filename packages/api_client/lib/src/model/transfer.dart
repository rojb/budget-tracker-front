//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer.g.dart';

/// Money moved between two accounts of the same plan. Never touches envelopes.
///
/// Properties:
/// * [id] - UUID v4 identifier.
/// * [fromAccountId] - UUID v4 identifier.
/// * [toAccountId] - UUID v4 identifier.
/// * [amountMinor] - Positive amount in the plan currency's minor units.
/// * [occurredAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
/// * [createdAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
@BuiltValue()
abstract class Transfer implements Built<Transfer, TransferBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'id')
  String get id;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'fromAccountId')
  String get fromAccountId;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'toAccountId')
  String get toAccountId;

  /// Positive amount in the plan currency's minor units.
  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'occurredAt')
  DateTime get occurredAt;

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  Transfer._();

  factory Transfer([void updates(TransferBuilder b)]) = _$Transfer;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransferBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Transfer> get serializer => _$TransferSerializer();
}

class _$TransferSerializer implements PrimitiveSerializer<Transfer> {
  @override
  final Iterable<Type> types = const [Transfer, _$Transfer];

  @override
  final String wireName = r'Transfer';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Transfer object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'fromAccountId';
    yield serializers.serialize(
      object.fromAccountId,
      specifiedType: const FullType(String),
    );
    yield r'toAccountId';
    yield serializers.serialize(
      object.toAccountId,
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
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Transfer object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransferBuilder result,
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
        case r'fromAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fromAccountId = valueDes;
          break;
        case r'toAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.toAccountId = valueDes;
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
  Transfer deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransferBuilder();
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


