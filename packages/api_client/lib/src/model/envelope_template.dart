//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/template_group.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_template.g.dart';

/// The suggested starter template, the same for every plan (4 groups, 12 envelopes).
///
/// Properties:
/// * [groups] 
@BuiltValue()
abstract class EnvelopeTemplate implements Built<EnvelopeTemplate, EnvelopeTemplateBuilder> {
  @BuiltValueField(wireName: r'groups')
  BuiltList<TemplateGroup> get groups;

  EnvelopeTemplate._();

  factory EnvelopeTemplate([void updates(EnvelopeTemplateBuilder b)]) = _$EnvelopeTemplate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeTemplateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnvelopeTemplate> get serializer => _$EnvelopeTemplateSerializer();
}

class _$EnvelopeTemplateSerializer implements PrimitiveSerializer<EnvelopeTemplate> {
  @override
  final Iterable<Type> types = const [EnvelopeTemplate, _$EnvelopeTemplate];

  @override
  final String wireName = r'EnvelopeTemplate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnvelopeTemplate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'groups';
    yield serializers.serialize(
      object.groups,
      specifiedType: const FullType(BuiltList, [FullType(TemplateGroup)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EnvelopeTemplate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeTemplateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'groups':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TemplateGroup)]),
          ) as BuiltList<TemplateGroup>;
          result.groups.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EnvelopeTemplate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeTemplateBuilder();
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


