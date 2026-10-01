//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/page_meta.dart';
import 'package:api_client/src/model/transaction.dart';
import 'package:api_client/src/model/transaction_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_page.g.dart';

/// TransactionPage
///
/// Properties:
/// * [page] 
/// * [pageSize] 
/// * [total] - Count of all matching items across pages.
/// * [items] 
/// * [summary] 
@BuiltValue()
abstract class TransactionPage implements PageMeta, Built<TransactionPage, TransactionPageBuilder> {
  @BuiltValueField(wireName: r'summary')
  TransactionSummary get summary;

  @BuiltValueField(wireName: r'items')
  BuiltList<Transaction> get items;

  TransactionPage._();

  factory TransactionPage([void updates(TransactionPageBuilder b)]) = _$TransactionPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionPage> get serializer => _$TransactionPageSerializer();
}

class _$TransactionPageSerializer implements PrimitiveSerializer<TransactionPage> {
  @override
  final Iterable<Type> types = const [TransactionPage, _$TransactionPage];

  @override
  final String wireName = r'TransactionPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'summary';
    yield serializers.serialize(
      object.summary,
      specifiedType: const FullType(TransactionSummary),
    );
    yield r'pageSize';
    yield serializers.serialize(
      object.pageSize,
      specifiedType: const FullType(int),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
    yield r'page';
    yield serializers.serialize(
      object.page,
      specifiedType: const FullType(int),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(Transaction)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionSummary),
          ) as TransactionSummary;
          result.summary.replace(valueDes);
          break;
        case r'pageSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageSize = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        case r'page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.page = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Transaction)]),
          ) as BuiltList<Transaction>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionPageBuilder();
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


