//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope.dart';
import 'package:api_client/src/model/envelope_state.dart';
import 'package:api_client/src/model/goal_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_line.g.dart';

/// An envelope with the figures the budget engine derives for a month, its state and, with a goal, the goal status.
///
/// Properties:
/// * [envelope] 
/// * [assignedMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [spentMinor] - Net outflow of the month (expenses minus income sent to the envelope); negative when income exceeds expenses.
/// * [availableMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [state] 
/// * [goalStatus] 
@BuiltValue()
abstract class EnvelopeLine implements Built<EnvelopeLine, EnvelopeLineBuilder> {
  @BuiltValueField(wireName: r'envelope')
  Envelope get envelope;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'assignedMinor')
  int get assignedMinor;

  /// Net outflow of the month (expenses minus income sent to the envelope); negative when income exceeds expenses.
  @BuiltValueField(wireName: r'spentMinor')
  int get spentMinor;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'availableMinor')
  int get availableMinor;

  @BuiltValueField(wireName: r'state')
  EnvelopeState get state;
  // enum stateEnum {  funded,  underfunded,  overspent,  };

  @BuiltValueField(wireName: r'goalStatus')
  GoalStatus? get goalStatus;

  EnvelopeLine._();

  factory EnvelopeLine([void updates(EnvelopeLineBuilder b)]) = _$EnvelopeLine;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeLineBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnvelopeLine> get serializer => _$EnvelopeLineSerializer();
}

class _$EnvelopeLineSerializer implements PrimitiveSerializer<EnvelopeLine> {
  @override
  final Iterable<Type> types = const [EnvelopeLine, _$EnvelopeLine];

  @override
  final String wireName = r'EnvelopeLine';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnvelopeLine object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'envelope';
    yield serializers.serialize(
      object.envelope,
      specifiedType: const FullType(Envelope),
    );
    yield r'assignedMinor';
    yield serializers.serialize(
      object.assignedMinor,
      specifiedType: const FullType(int),
    );
    yield r'spentMinor';
    yield serializers.serialize(
      object.spentMinor,
      specifiedType: const FullType(int),
    );
    yield r'availableMinor';
    yield serializers.serialize(
      object.availableMinor,
      specifiedType: const FullType(int),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(EnvelopeState),
    );
    if (object.goalStatus != null) {
      yield r'goalStatus';
      yield serializers.serialize(
        object.goalStatus,
        specifiedType: const FullType(GoalStatus),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EnvelopeLine object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeLineBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'envelope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Envelope),
          ) as Envelope;
          result.envelope.replace(valueDes);
          break;
        case r'assignedMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.assignedMinor = valueDes;
          break;
        case r'spentMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.spentMinor = valueDes;
          break;
        case r'availableMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.availableMinor = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnvelopeState),
          ) as EnvelopeState;
          result.state = valueDes;
          break;
        case r'goalStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(GoalStatus),
          ) as GoalStatus?;
          if (valueDes == null) continue;
          result.goalStatus.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EnvelopeLine deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeLineBuilder();
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


