//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/envelope_group.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_template_result.g.dart';

/// EnvelopeTemplateResult
///
/// Properties:
/// * [groups] 
/// * [envelopes] 
@BuiltValue()
abstract class EnvelopeTemplateResult implements Built<EnvelopeTemplateResult, EnvelopeTemplateResultBuilder> {
  @BuiltValueField(wireName: r'groups')
  BuiltList<EnvelopeGroup> get groups;

  @BuiltValueField(wireName: r'envelopes')
  BuiltList<Envelope> get envelopes;

  EnvelopeTemplateResult._();

  factory EnvelopeTemplateResult([void updates(EnvelopeTemplateResultBuilder b)]) = _$EnvelopeTemplateResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeTemplateResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnvelopeTemplateResult> get serializer => _$EnvelopeTemplateResultSerializer();
}

class _$EnvelopeTemplateResultSerializer implements PrimitiveSerializer<EnvelopeTemplateResult> {
  @override
  final Iterable<Type> types = const [EnvelopeTemplateResult, _$EnvelopeTemplateResult];

  @override
  final String wireName = r'EnvelopeTemplateResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnvelopeTemplateResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'groups';
    yield serializers.serialize(
      object.groups,
      specifiedType: const FullType(BuiltList, [FullType(EnvelopeGroup)]),
    );
    yield r'envelopes';
    yield serializers.serialize(
      object.envelopes,
      specifiedType: const FullType(BuiltList, [FullType(Envelope)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EnvelopeTemplateResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeTemplateResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'groups':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EnvelopeGroup)]),
          ) as BuiltList<EnvelopeGroup>;
          result.groups.replace(valueDes);
          break;
        case r'envelopes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Envelope)]),
          ) as BuiltList<Envelope>;
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
  EnvelopeTemplateResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeTemplateResultBuilder();
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


