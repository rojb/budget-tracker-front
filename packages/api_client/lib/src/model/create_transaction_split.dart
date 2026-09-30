//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_transaction_split.g.dart';

/// CreateTransactionSplit
///
/// Properties:
/// * [envelopeId] - UUID v4 identifier.
/// * [amountMinor] 
@BuiltValue()
abstract class CreateTransactionSplit implements Built<CreateTransactionSplit, CreateTransactionSplitBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'envelopeId')
  String get envelopeId;

  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  CreateTransactionSplit._();

  factory CreateTransactionSplit([void updates(CreateTransactionSplitBuilder b)]) = _$CreateTransactionSplit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateTransactionSplitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateTransactionSplit> get serializer => _$CreateTransactionSplitSerializer();
}

class _$CreateTransactionSplitSerializer implements PrimitiveSerializer<CreateTransactionSplit> {
  @override
  final Iterable<Type> types = const [CreateTransactionSplit, _$CreateTransactionSplit];

  @override
  final String wireName = r'CreateTransactionSplit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateTransactionSplit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'envelopeId';
    yield serializers.serialize(
      object.envelopeId,
      specifiedType: const FullType(String),
    );
    yield r'amountMinor';
    yield serializers.serialize(
      object.amountMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateTransactionSplit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateTransactionSplitBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'envelopeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.envelopeId = valueDes;
          break;
        case r'amountMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amountMinor = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateTransactionSplit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateTransactionSplitBuilder();
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


