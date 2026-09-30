//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'apply_envelope_template_request.g.dart';

/// ApplyEnvelopeTemplateRequest
///
/// Properties:
/// * [envelopeNames] - Names of the template envelopes to create; all of them when absent.
@BuiltValue()
abstract class ApplyEnvelopeTemplateRequest implements Built<ApplyEnvelopeTemplateRequest, ApplyEnvelopeTemplateRequestBuilder> {
  /// Names of the template envelopes to create; all of them when absent.
  @BuiltValueField(wireName: r'envelopeNames')
  BuiltList<String>? get envelopeNames;

  ApplyEnvelopeTemplateRequest._();

  factory ApplyEnvelopeTemplateRequest([void updates(ApplyEnvelopeTemplateRequestBuilder b)]) = _$ApplyEnvelopeTemplateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApplyEnvelopeTemplateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApplyEnvelopeTemplateRequest> get serializer => _$ApplyEnvelopeTemplateRequestSerializer();
}

class _$ApplyEnvelopeTemplateRequestSerializer implements PrimitiveSerializer<ApplyEnvelopeTemplateRequest> {
  @override
  final Iterable<Type> types = const [ApplyEnvelopeTemplateRequest, _$ApplyEnvelopeTemplateRequest];

  @override
  final String wireName = r'ApplyEnvelopeTemplateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApplyEnvelopeTemplateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.envelopeNames != null) {
      yield r'envelopeNames';
      yield serializers.serialize(
        object.envelopeNames,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApplyEnvelopeTemplateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApplyEnvelopeTemplateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'envelopeNames':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.envelopeNames.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApplyEnvelopeTemplateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApplyEnvelopeTemplateRequestBuilder();
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


