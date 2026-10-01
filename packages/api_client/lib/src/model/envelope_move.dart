//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_move.g.dart';

/// One recorded move of money between two envelopes, seen from the envelope of the detail.
///
/// Properties:
/// * [id] - UUID v4 identifier.
/// * [direction] - `out` when the envelope was the source (money left it), `in` when it was the destination.
/// * [counterpartId] - The other envelope; absent when it was deleted afterwards.
/// * [counterpartName] - Name of the other envelope (the name it had when it was deleted, if it no longer exists).
/// * [amountMinor] 
/// * [month] - The month the move was made for.
/// * [createdAt] - Registration instant of the move.
@BuiltValue()
abstract class EnvelopeMove implements Built<EnvelopeMove, EnvelopeMoveBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'id')
  String get id;

  /// `out` when the envelope was the source (money left it), `in` when it was the destination.
  @BuiltValueField(wireName: r'direction')
  EnvelopeMoveDirectionEnum get direction;
  // enum directionEnum {  in,  out,  };

  /// The other envelope; absent when it was deleted afterwards.
  @BuiltValueField(wireName: r'counterpartId')
  String? get counterpartId;

  /// Name of the other envelope (the name it had when it was deleted, if it no longer exists).
  @BuiltValueField(wireName: r'counterpartName')
  String get counterpartName;

  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  /// The month the move was made for.
  @BuiltValueField(wireName: r'month')
  String get month;

  /// Registration instant of the move.
  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  EnvelopeMove._();

  factory EnvelopeMove([void updates(EnvelopeMoveBuilder b)]) = _$EnvelopeMove;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeMoveBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnvelopeMove> get serializer => _$EnvelopeMoveSerializer();
}

class _$EnvelopeMoveSerializer implements PrimitiveSerializer<EnvelopeMove> {
  @override
  final Iterable<Type> types = const [EnvelopeMove, _$EnvelopeMove];

  @override
  final String wireName = r'EnvelopeMove';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnvelopeMove object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'direction';
    yield serializers.serialize(
      object.direction,
      specifiedType: const FullType(EnvelopeMoveDirectionEnum),
    );
    if (object.counterpartId != null) {
      yield r'counterpartId';
      yield serializers.serialize(
        object.counterpartId,
        specifiedType: const FullType(String),
      );
    }
    yield r'counterpartName';
    yield serializers.serialize(
      object.counterpartName,
      specifiedType: const FullType(String),
    );
    yield r'amountMinor';
    yield serializers.serialize(
      object.amountMinor,
      specifiedType: const FullType(int),
    );
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
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
    EnvelopeMove object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeMoveBuilder result,
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
        case r'direction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnvelopeMoveDirectionEnum),
          ) as EnvelopeMoveDirectionEnum;
          result.direction = valueDes;
          break;
        case r'counterpartId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.counterpartId = valueDes;
          break;
        case r'counterpartName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.counterpartName = valueDes;
          break;
        case r'amountMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amountMinor = valueDes;
          break;
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.month = valueDes;
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
  EnvelopeMove deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeMoveBuilder();
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


/// `out` when the envelope was the source (money left it), `in` when it was the destination.
class EnvelopeMoveDirectionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'in')
  static const EnvelopeMoveDirectionEnum in_ = _$envelopeMoveDirectionEnum_in_;
  @BuiltValueEnumConst(wireName: r'out')
  static const EnvelopeMoveDirectionEnum out_ = _$envelopeMoveDirectionEnum_out_;

  static Serializer<EnvelopeMoveDirectionEnum> get serializer => _$envelopeMoveDirectionEnumSerializer;

  const EnvelopeMoveDirectionEnum._(String name): super(name);

  static BuiltSet<EnvelopeMoveDirectionEnum> get values => _$envelopeMoveDirectionEnumValues;
  static EnvelopeMoveDirectionEnum valueOf(String name) => _$envelopeMoveDirectionEnumValueOf(name);
}

