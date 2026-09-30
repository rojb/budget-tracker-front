//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/template_envelope.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'template_group.g.dart';

/// TemplateGroup
///
/// Properties:
/// * [name] 
/// * [envelopes] 
@BuiltValue()
abstract class TemplateGroup implements Built<TemplateGroup, TemplateGroupBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'envelopes')
  BuiltList<TemplateEnvelope> get envelopes;

  TemplateGroup._();

  factory TemplateGroup([void updates(TemplateGroupBuilder b)]) = _$TemplateGroup;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TemplateGroupBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TemplateGroup> get serializer => _$TemplateGroupSerializer();
}

class _$TemplateGroupSerializer implements PrimitiveSerializer<TemplateGroup> {
  @override
  final Iterable<Type> types = const [TemplateGroup, _$TemplateGroup];

  @override
  final String wireName = r'TemplateGroup';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TemplateGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'envelopes';
    yield serializers.serialize(
      object.envelopes,
      specifiedType: const FullType(BuiltList, [FullType(TemplateEnvelope)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TemplateGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TemplateGroupBuilder result,
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
        case r'envelopes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TemplateEnvelope)]),
          ) as BuiltList<TemplateEnvelope>;
          result.envelopes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TemplateGroup deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TemplateGroupBuilder();
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


