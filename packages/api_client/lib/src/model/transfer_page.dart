//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transfer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/page_meta.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_page.g.dart';

/// TransferPage
///
/// Properties:
/// * [page] 
/// * [pageSize] 
/// * [total] - Count of all matching items across pages.
/// * [items] 
@BuiltValue()
abstract class TransferPage implements PageMeta, Built<TransferPage, TransferPageBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<Transfer> get items;

  TransferPage._();

  factory TransferPage([void updates(TransferPageBuilder b)]) = _$TransferPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransferPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransferPage> get serializer => _$TransferPageSerializer();
}

class _$TransferPageSerializer implements PrimitiveSerializer<TransferPage> {
  @override
  final Iterable<Type> types = const [TransferPage, _$TransferPage];

  @override
  final String wireName = r'TransferPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransferPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
      specifiedType: const FullType(BuiltList, [FullType(Transfer)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransferPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransferPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(BuiltList, [FullType(Transfer)]),
          ) as BuiltList<Transfer>;
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
  TransferPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransferPageBuilder();
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


