//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/page_meta.dart';
import 'package:api_client/src/model/payee.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payee_page.g.dart';

/// PayeePage
///
/// Properties:
/// * [page] 
/// * [pageSize] 
/// * [total] - Count of all matching items across pages.
/// * [items] 
@BuiltValue()
abstract class PayeePage implements PageMeta, Built<PayeePage, PayeePageBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<Payee> get items;

  PayeePage._();

  factory PayeePage([void updates(PayeePageBuilder b)]) = _$PayeePage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayeePageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayeePage> get serializer => _$PayeePageSerializer();
}

class _$PayeePageSerializer implements PrimitiveSerializer<PayeePage> {
  @override
  final Iterable<Type> types = const [PayeePage, _$PayeePage];

  @override
  final String wireName = r'PayeePage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayeePage object, {
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
      specifiedType: const FullType(BuiltList, [FullType(Payee)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PayeePage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayeePageBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(Payee)]),
          ) as BuiltList<Payee>;
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
  PayeePage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayeePageBuilder();
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


