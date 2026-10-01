//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope_line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'move_money_result.g.dart';

/// MoveMoneyResult
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [readyToAssignMinor] - Ready to Assign of the month; a move never changes it.
/// * [from] 
/// * [to] 
@BuiltValue()
abstract class MoveMoneyResult implements Built<MoveMoneyResult, MoveMoneyResultBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  /// Ready to Assign of the month; a move never changes it.
  @BuiltValueField(wireName: r'readyToAssignMinor')
  int get readyToAssignMinor;

  @BuiltValueField(wireName: r'from')
  EnvelopeLine get from;

  @BuiltValueField(wireName: r'to')
  EnvelopeLine get to;

  MoveMoneyResult._();

  factory MoveMoneyResult([void updates(MoveMoneyResultBuilder b)]) = _$MoveMoneyResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MoveMoneyResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MoveMoneyResult> get serializer => _$MoveMoneyResultSerializer();
}

class _$MoveMoneyResultSerializer implements PrimitiveSerializer<MoveMoneyResult> {
  @override
  final Iterable<Type> types = const [MoveMoneyResult, _$MoveMoneyResult];

  @override
  final String wireName = r'MoveMoneyResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MoveMoneyResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'readyToAssignMinor';
    yield serializers.serialize(
      object.readyToAssignMinor,
      specifiedType: const FullType(int),
    );
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(EnvelopeLine),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(EnvelopeLine),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MoveMoneyResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MoveMoneyResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.month = valueDes;
          break;
        case r'readyToAssignMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.readyToAssignMinor = valueDes;
          break;
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnvelopeLine),
          ) as EnvelopeLine;
          result.from.replace(valueDes);
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnvelopeLine),
          ) as EnvelopeLine;
          result.to.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MoveMoneyResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MoveMoneyResultBuilder();
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


