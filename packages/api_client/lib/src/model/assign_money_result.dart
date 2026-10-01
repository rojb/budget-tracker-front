//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope_line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assign_money_result.g.dart';

/// AssignMoneyResult
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [readyToAssignMinor] - Ready to Assign of the month after the assignment; negative when over-assigned.
/// * [line] 
@BuiltValue()
abstract class AssignMoneyResult implements Built<AssignMoneyResult, AssignMoneyResultBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  /// Ready to Assign of the month after the assignment; negative when over-assigned.
  @BuiltValueField(wireName: r'readyToAssignMinor')
  int get readyToAssignMinor;

  @BuiltValueField(wireName: r'line')
  EnvelopeLine get line;

  AssignMoneyResult._();

  factory AssignMoneyResult([void updates(AssignMoneyResultBuilder b)]) = _$AssignMoneyResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignMoneyResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssignMoneyResult> get serializer => _$AssignMoneyResultSerializer();
}

class _$AssignMoneyResultSerializer implements PrimitiveSerializer<AssignMoneyResult> {
  @override
  final Iterable<Type> types = const [AssignMoneyResult, _$AssignMoneyResult];

  @override
  final String wireName = r'AssignMoneyResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssignMoneyResult object, {
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
    yield r'line';
    yield serializers.serialize(
      object.line,
      specifiedType: const FullType(EnvelopeLine),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AssignMoneyResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignMoneyResultBuilder result,
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
        case r'line':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnvelopeLine),
          ) as EnvelopeLine;
          result.line.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AssignMoneyResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignMoneyResultBuilder();
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


