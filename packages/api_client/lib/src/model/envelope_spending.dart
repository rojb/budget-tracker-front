//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope_icon.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_spending.g.dart';

/// EnvelopeSpending
///
/// Properties:
/// * [envelopeId] - UUID v4 identifier.
/// * [name] 
/// * [icon] 
/// * [amountMinor] 
@BuiltValue()
abstract class EnvelopeSpending implements Built<EnvelopeSpending, EnvelopeSpendingBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'envelopeId')
  String get envelopeId;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'icon')
  EnvelopeIcon get icon;
  // enum iconEnum {  tag,  home,  bus,  utensils,  heartPulse,  gift,  cart,  pill,  wifi,  settings,  ticket,  repeat,  lifeBuoy,  plane,  };

  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  EnvelopeSpending._();

  factory EnvelopeSpending([void updates(EnvelopeSpendingBuilder b)]) = _$EnvelopeSpending;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeSpendingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnvelopeSpending> get serializer => _$EnvelopeSpendingSerializer();
}

class _$EnvelopeSpendingSerializer implements PrimitiveSerializer<EnvelopeSpending> {
  @override
  final Iterable<Type> types = const [EnvelopeSpending, _$EnvelopeSpending];

  @override
  final String wireName = r'EnvelopeSpending';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnvelopeSpending object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'envelopeId';
    yield serializers.serialize(
      object.envelopeId,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'icon';
    yield serializers.serialize(
      object.icon,
      specifiedType: const FullType(EnvelopeIcon),
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
    EnvelopeSpending object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeSpendingBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnvelopeIcon),
          ) as EnvelopeIcon;
          result.icon = valueDes;
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
  EnvelopeSpending deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeSpendingBuilder();
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


