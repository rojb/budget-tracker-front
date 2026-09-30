//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_split.g.dart';

/// One portion of a transaction. `envelopeId` is absent for an income sent to Ready to Assign and for a portion whose envelope was deleted (\"Sin sobre\"). 
///
/// Properties:
/// * [envelopeId] - UUID v4 identifier.
/// * [envelopeName] 
/// * [amountMinor] 
@BuiltValue()
abstract class TransactionSplit implements Built<TransactionSplit, TransactionSplitBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'envelopeId')
  String? get envelopeId;

  @BuiltValueField(wireName: r'envelopeName')
  String? get envelopeName;

  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  TransactionSplit._();

  factory TransactionSplit([void updates(TransactionSplitBuilder b)]) = _$TransactionSplit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionSplitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionSplit> get serializer => _$TransactionSplitSerializer();
}

class _$TransactionSplitSerializer implements PrimitiveSerializer<TransactionSplit> {
  @override
  final Iterable<Type> types = const [TransactionSplit, _$TransactionSplit];

  @override
  final String wireName = r'TransactionSplit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionSplit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.envelopeId != null) {
      yield r'envelopeId';
      yield serializers.serialize(
        object.envelopeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.envelopeName != null) {
      yield r'envelopeName';
      yield serializers.serialize(
        object.envelopeName,
        specifiedType: const FullType(String),
      );
    }
    yield r'amountMinor';
    yield serializers.serialize(
      object.amountMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionSplit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionSplitBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'envelopeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.envelopeId = valueDes;
          break;
        case r'envelopeName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.envelopeName = valueDes;
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
  TransactionSplit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionSplitBuilder();
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


