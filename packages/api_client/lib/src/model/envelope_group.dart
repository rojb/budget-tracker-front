//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_group.g.dart';

/// An ordered group of envelopes of a plan.
///
/// Properties:
/// * [id] - UUID v4 identifier.
/// * [name] 
/// * [position] - Zero-based place of the group in the plan.
/// * [envelopeCount] 
/// * [createdAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
@BuiltValue()
abstract class EnvelopeGroup implements Built<EnvelopeGroup, EnvelopeGroupBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  /// Zero-based place of the group in the plan.
  @BuiltValueField(wireName: r'position')
  int get position;

  @BuiltValueField(wireName: r'envelopeCount')
  int get envelopeCount;

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  EnvelopeGroup._();

  factory EnvelopeGroup([void updates(EnvelopeGroupBuilder b)]) = _$EnvelopeGroup;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeGroupBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnvelopeGroup> get serializer => _$EnvelopeGroupSerializer();
}

class _$EnvelopeGroupSerializer implements PrimitiveSerializer<EnvelopeGroup> {
  @override
  final Iterable<Type> types = const [EnvelopeGroup, _$EnvelopeGroup];

  @override
  final String wireName = r'EnvelopeGroup';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnvelopeGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'position';
    yield serializers.serialize(
      object.position,
      specifiedType: const FullType(int),
    );
    yield r'envelopeCount';
    yield serializers.serialize(
      object.envelopeCount,
      specifiedType: const FullType(int),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EnvelopeGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeGroupBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'position':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.position = valueDes;
          break;
        case r'envelopeCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.envelopeCount = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EnvelopeGroup deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeGroupBuilder();
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


