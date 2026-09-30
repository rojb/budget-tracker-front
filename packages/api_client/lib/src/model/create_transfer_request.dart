//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_transfer_request.g.dart';

/// CreateTransferRequest
///
/// Properties:
/// * [fromAccountId] - UUID v4 identifier.
/// * [toAccountId] - UUID v4 identifier.
/// * [amountMinor] 
/// * [occurredAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
@BuiltValue()
abstract class CreateTransferRequest implements Built<CreateTransferRequest, CreateTransferRequestBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'fromAccountId')
  String get fromAccountId;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'toAccountId')
  String get toAccountId;

  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'occurredAt')
  DateTime get occurredAt;

  CreateTransferRequest._();

  factory CreateTransferRequest([void updates(CreateTransferRequestBuilder b)]) = _$CreateTransferRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateTransferRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateTransferRequest> get serializer => _$CreateTransferRequestSerializer();
}

class _$CreateTransferRequestSerializer implements PrimitiveSerializer<CreateTransferRequest> {
  @override
  final Iterable<Type> types = const [CreateTransferRequest, _$CreateTransferRequest];

  @override
  final String wireName = r'CreateTransferRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateTransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateTransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateTransferRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateTransferRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateTransferRequestBuilder();
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


