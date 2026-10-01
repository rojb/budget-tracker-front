//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope_goal.dart';
import 'package:api_client/src/model/envelope_icon.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope.g.dart';

/// An envelope of a plan. `groupId` is absent when it has no group (\"Sin grupo\").
///
/// Properties:
/// * [id] - UUID v4 identifier.
/// * [name] 
/// * [icon] 
/// * [groupId] - UUID v4 identifier.
/// * [position] - Zero-based place inside its group (or among the envelopes without a group).
/// * [goal] 
/// * [photoUrl] - Path, relative to the API, of the envelope's photo (served only to members with a bearer token). It carries a `v` version query, so a changed photo is a new URL. Absent when the envelope has no photo.
/// * [createdAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
@BuiltValue()
abstract class Envelope implements Built<Envelope, EnvelopeBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'icon')
  EnvelopeIcon get icon;
  // enum iconEnum {  tag,  home,  bus,  utensils,  heartPulse,  gift,  cart,  pill,  wifi,  settings,  ticket,  repeat,  lifeBuoy,  plane,  };

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'groupId')
  String? get groupId;

  /// Zero-based place inside its group (or among the envelopes without a group).
  @BuiltValueField(wireName: r'position')
  int get position;

  @BuiltValueField(wireName: r'goal')
  EnvelopeGoal? get goal;

  /// Path, relative to the API, of the envelope's photo (served only to members with a bearer token). It carries a `v` version query, so a changed photo is a new URL. Absent when the envelope has no photo.
  @BuiltValueField(wireName: r'photoUrl')
  String? get photoUrl;

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  Envelope._();

  factory Envelope([void updates(EnvelopeBuilder b)]) = _$Envelope;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Envelope> get serializer => _$EnvelopeSerializer();
}

class _$EnvelopeSerializer implements PrimitiveSerializer<Envelope> {
  @override
  final Iterable<Type> types = const [Envelope, _$Envelope];

  @override
  final String wireName = r'Envelope';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Envelope object, {
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
    yield r'icon';
    yield serializers.serialize(
      object.icon,
      specifiedType: const FullType(EnvelopeIcon),
    );
    if (object.groupId != null) {
      yield r'groupId';
      yield serializers.serialize(
        object.groupId,
        specifiedType: const FullType(String),
      );
    }
    yield r'position';
    yield serializers.serialize(
      object.position,
      specifiedType: const FullType(int),
    );
    if (object.goal != null) {
      yield r'goal';
      yield serializers.serialize(
        object.goal,
        specifiedType: const FullType(EnvelopeGoal),
      );
    }
    if (object.photoUrl != null) {
      yield r'photoUrl';
      yield serializers.serialize(
        object.photoUrl,
        specifiedType: const FullType(String),
      );
    }
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Envelope object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeBuilder result,
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
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnvelopeIcon),
          ) as EnvelopeIcon;
          result.icon = valueDes;
          break;
        case r'groupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.groupId = valueDes;
          break;
        case r'position':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.position = valueDes;
          break;
        case r'goal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(EnvelopeGoal),
          ) as EnvelopeGoal?;
          if (valueDes == null) continue;
          result.goal.replace(valueDes);
          break;
        case r'photoUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoUrl = valueDes;
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
  Envelope deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeBuilder();
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


