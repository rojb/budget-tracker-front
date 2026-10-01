//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_summary.g.dart';

/// Totals of every transaction the filters select, not only of the returned page: the money that left (expenses) and the money that came in (incomes), each transaction with its whole amount. 
///
/// Properties:
/// * [outflowMinor] 
/// * [inflowMinor] 
@BuiltValue()
abstract class TransactionSummary implements Built<TransactionSummary, TransactionSummaryBuilder> {
  @BuiltValueField(wireName: r'outflowMinor')
  int get outflowMinor;

  @BuiltValueField(wireName: r'inflowMinor')
  int get inflowMinor;

  TransactionSummary._();

  factory TransactionSummary([void updates(TransactionSummaryBuilder b)]) = _$TransactionSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionSummary> get serializer => _$TransactionSummarySerializer();
}

class _$TransactionSummarySerializer implements PrimitiveSerializer<TransactionSummary> {
  @override
  final Iterable<Type> types = const [TransactionSummary, _$TransactionSummary];

  @override
  final String wireName = r'TransactionSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'outflowMinor';
    yield serializers.serialize(
      object.outflowMinor,
      specifiedType: const FullType(int),
    );
    yield r'inflowMinor';
    yield serializers.serialize(
      object.inflowMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'outflowMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.outflowMinor = valueDes;
          break;
        case r'inflowMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.inflowMinor = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionSummaryBuilder();
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


