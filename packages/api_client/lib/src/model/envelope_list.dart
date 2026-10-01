//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/envelope_line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_list.g.dart';

/// EnvelopeList
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [readyToAssignMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD, EUR and BOB are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [items] 
@BuiltValue()
abstract class EnvelopeList implements Built<EnvelopeList, EnvelopeListBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD, EUR and BOB are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'readyToAssignMinor')
  int get readyToAssignMinor;

  @BuiltValueField(wireName: r'items')
  BuiltList<EnvelopeLine> get items;

  EnvelopeList._();

  factory EnvelopeList([void updates(EnvelopeListBuilder b)]) = _$EnvelopeList;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeListBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnvelopeList> get serializer => _$EnvelopeListSerializer();
}

class _$EnvelopeListSerializer implements PrimitiveSerializer<EnvelopeList> {
  @override
  final Iterable<Type> types = const [EnvelopeList, _$EnvelopeList];

  @override
  final String wireName = r'EnvelopeList';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnvelopeList object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'readyToAssignMinor';
    yield serializers.serialize(
      object.readyToAssignMinor,
      specifiedType: const FullType(int),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(EnvelopeLine)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EnvelopeList object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeListBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.month = valueDes;
          break;
        case r'readyToAssignMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.readyToAssignMinor = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EnvelopeLine)]),
          ) as BuiltList<EnvelopeLine>;
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
  EnvelopeList deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeListBuilder();
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


