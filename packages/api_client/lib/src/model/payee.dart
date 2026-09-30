//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payee.g.dart';

/// A payee of a plan. A deleted payee is still readable so past transactions can show it.
///
/// Properties:
/// * [id] - UUID v4 identifier.
/// * [name] 
/// * [suggestedEnvelopeId] - Envelope proposed when this payee is chosen; absent when there is none.
/// * [transactionCount] - Transactions that reference this payee.
/// * [deleted] 
/// * [createdAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
@BuiltValue()
abstract class Payee implements Built<Payee, PayeeBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  /// Envelope proposed when this payee is chosen; absent when there is none.
  @BuiltValueField(wireName: r'suggestedEnvelopeId')
  String? get suggestedEnvelopeId;

  /// Transactions that reference this payee.
  @BuiltValueField(wireName: r'transactionCount')
  int get transactionCount;

  @BuiltValueField(wireName: r'deleted')
  bool get deleted;

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  Payee._();

  factory Payee([void updates(PayeeBuilder b)]) = _$Payee;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayeeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Payee> get serializer => _$PayeeSerializer();
}

class _$PayeeSerializer implements PrimitiveSerializer<Payee> {
  @override
  final Iterable<Type> types = const [Payee, _$Payee];

  @override
  final String wireName = r'Payee';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Payee object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.suggestedEnvelopeId != null) {
      yield r'suggestedEnvelopeId';
      yield serializers.serialize(
        object.suggestedEnvelopeId,
        specifiedType: const FullType(String),
      );
    }
    yield r'transactionCount';
    yield serializers.serialize(
      object.transactionCount,
      specifiedType: const FullType(int),
    );
    yield r'deleted';
    yield serializers.serialize(
      object.deleted,
      specifiedType: const FullType(bool),
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
    Payee object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayeeBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'suggestedEnvelopeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.suggestedEnvelopeId = valueDes;
          break;
        case r'transactionCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.transactionCount = valueDes;
          break;
        case r'deleted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.deleted = valueDes;
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
  Payee deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayeeBuilder();
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


