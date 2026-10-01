//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'move_money_request.g.dart';

/// MoveMoneyRequest
///
/// Properties:
/// * [fromEnvelopeId] - UUID v4 identifier.
/// * [toEnvelopeId] - UUID v4 identifier.
/// * [amountMinor] 
/// * [month] - Budget month as YYYY-MM.
@BuiltValue()
abstract class MoveMoneyRequest implements Built<MoveMoneyRequest, MoveMoneyRequestBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'fromEnvelopeId')
  String get fromEnvelopeId;

  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'toEnvelopeId')
  String get toEnvelopeId;

  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String? get month;

  MoveMoneyRequest._();

  factory MoveMoneyRequest([void updates(MoveMoneyRequestBuilder b)]) = _$MoveMoneyRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MoveMoneyRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MoveMoneyRequest> get serializer => _$MoveMoneyRequestSerializer();
}

class _$MoveMoneyRequestSerializer implements PrimitiveSerializer<MoveMoneyRequest> {
  @override
  final Iterable<Type> types = const [MoveMoneyRequest, _$MoveMoneyRequest];

  @override
  final String wireName = r'MoveMoneyRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MoveMoneyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'fromEnvelopeId';
    yield serializers.serialize(
      object.fromEnvelopeId,
      specifiedType: const FullType(String),
    );
    yield r'toEnvelopeId';
    yield serializers.serialize(
      object.toEnvelopeId,
      specifiedType: const FullType(String),
    );
    yield r'amountMinor';
    yield serializers.serialize(
      object.amountMinor,
      specifiedType: const FullType(int),
    );
    if (object.month != null) {
      yield r'month';
      yield serializers.serialize(
        object.month,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MoveMoneyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MoveMoneyRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fromEnvelopeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fromEnvelopeId = valueDes;
          break;
        case r'toEnvelopeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.toEnvelopeId = valueDes;
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
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.month = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MoveMoneyRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MoveMoneyRequestBuilder();
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


