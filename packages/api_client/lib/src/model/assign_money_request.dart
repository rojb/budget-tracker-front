//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assign_money_request.g.dart';

/// AssignMoneyRequest
///
/// Properties:
/// * [envelopeId] - UUID v4 identifier.
/// * [amountMinor] - Amount added to the envelope's assignment of the month; negative takes money back, never 0.
@BuiltValue()
abstract class AssignMoneyRequest implements Built<AssignMoneyRequest, AssignMoneyRequestBuilder> {
  /// UUID v4 identifier.
  @BuiltValueField(wireName: r'envelopeId')
  String get envelopeId;

  /// Amount added to the envelope's assignment of the month; negative takes money back, never 0.
  @BuiltValueField(wireName: r'amountMinor')
  int get amountMinor;

  AssignMoneyRequest._();

  factory AssignMoneyRequest([void updates(AssignMoneyRequestBuilder b)]) = _$AssignMoneyRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignMoneyRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssignMoneyRequest> get serializer => _$AssignMoneyRequestSerializer();
}

class _$AssignMoneyRequestSerializer implements PrimitiveSerializer<AssignMoneyRequest> {
  @override
  final Iterable<Type> types = const [AssignMoneyRequest, _$AssignMoneyRequest];

  @override
  final String wireName = r'AssignMoneyRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssignMoneyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'envelopeId';
    yield serializers.serialize(
      object.envelopeId,
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
    AssignMoneyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignMoneyRequestBuilder result,
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
  AssignMoneyRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignMoneyRequestBuilder();
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


