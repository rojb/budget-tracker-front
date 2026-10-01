//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'close_line.g.dart';

/// CloseLine
///
/// Properties:
/// * [envelopeId] - UUID v4 identifier.
/// * [name] 
/// * [amountMinor] - Amount carried, or deducted (positive), in minor units.
@BuiltValue()
abstract class CloseLine implements Built<CloseLine, CloseLineBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'envelopeId')
  String get envelopeId;

  @BuiltValueField(wireName: r'name')
  String get name;

  /// Amount carried, or deducted (positive), in minor units.
  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  CloseLine._();

  factory CloseLine([void updates(CloseLineBuilder b)]) = _$CloseLine;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CloseLineBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CloseLine> get serializer => _$CloseLineSerializer();
}

class _$CloseLineSerializer implements PrimitiveSerializer<CloseLine> {
  @override
  final Iterable<Type> types = const [CloseLine, _$CloseLine];

  @override
  final String wireName = r'CloseLine';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CloseLine object, {
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
    yield r'amountMinor';
    yield serializers.serialize(
      object.amountMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CloseLine object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CloseLineBuilder result,
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
  CloseLine deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CloseLineBuilder();
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


