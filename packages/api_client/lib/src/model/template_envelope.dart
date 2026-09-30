//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope_icon.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'template_envelope.g.dart';

/// TemplateEnvelope
///
/// Properties:
/// * [name] 
/// * [icon] 
@BuiltValue()
abstract class TemplateEnvelope implements Built<TemplateEnvelope, TemplateEnvelopeBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'icon')
  EnvelopeIcon get icon;
  // enum iconEnum {  tag,  home,  bus,  utensils,  heartPulse,  gift,  cart,  pill,  wifi,  settings,  ticket,  repeat,  lifeBuoy,  plane,  };

  TemplateEnvelope._();

  factory TemplateEnvelope([void updates(TemplateEnvelopeBuilder b)]) = _$TemplateEnvelope;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TemplateEnvelopeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TemplateEnvelope> get serializer => _$TemplateEnvelopeSerializer();
}

class _$TemplateEnvelopeSerializer implements PrimitiveSerializer<TemplateEnvelope> {
  @override
  final Iterable<Type> types = const [TemplateEnvelope, _$TemplateEnvelope];

  @override
  final String wireName = r'TemplateEnvelope';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TemplateEnvelope object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    TemplateEnvelope object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TemplateEnvelopeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TemplateEnvelope deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TemplateEnvelopeBuilder();
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


