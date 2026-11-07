//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/envelope_move.dart';
import 'package:api_client/src/model/transaction.dart';
import 'package:api_client/src/model/envelope_line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_detail.g.dart';

/// One envelope with the figures and the activity of a month.
///
/// Properties:
/// * [month] - Budget month as YYYY-MM.
/// * [line] 
/// * [carryoverMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD, EUR and BOB are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [activity] - Transactions of the month with a portion on the envelope, newest first by `createdAt` (ties by id), at most 100.
/// * [activityTotal] - Number of transactions of the month with a portion on the envelope.
/// * [moves] - Moves of money between envelopes made for the month in which the envelope was the source or the destination, newest first by `createdAt` (ties by id), at most 100. A client shows them with `activity`, merged by `createdAt`. They are history only and never count in `line.spentMinor`.
/// * [movesTotal] - Number of moves of the month in which the envelope was the source or the destination.
@BuiltValue()
abstract class EnvelopeDetail implements Built<EnvelopeDetail, EnvelopeDetailBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  @BuiltValueField(wireName: r'line')
  EnvelopeLine get line;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD, EUR and BOB are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'carryoverMinor')
  int get carryoverMinor;

  /// Transactions of the month with a portion on the envelope, newest first by `createdAt` (ties by id), at most 100.
  @BuiltValueField(wireName: r'activity')
  BuiltList<Transaction> get activity;

  /// Number of transactions of the month with a portion on the envelope.
  @BuiltValueField(wireName: r'activityTotal')
  int get activityTotal;

  /// Moves of money between envelopes made for the month in which the envelope was the source or the destination, newest first by `createdAt` (ties by id), at most 100. A client shows them with `activity`, merged by `createdAt`. They are history only and never count in `line.spentMinor`.
  @BuiltValueField(wireName: r'moves')
  BuiltList<EnvelopeMove> get moves;

  /// Number of moves of the month in which the envelope was the source or the destination.
  @BuiltValueField(wireName: r'movesTotal')
  int get movesTotal;

  EnvelopeDetail._();

  factory EnvelopeDetail([void updates(EnvelopeDetailBuilder b)]) = _$EnvelopeDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EnvelopeDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EnvelopeDetail> get serializer => _$EnvelopeDetailSerializer();
}

class _$EnvelopeDetailSerializer implements PrimitiveSerializer<EnvelopeDetail> {
  @override
  final Iterable<Type> types = const [EnvelopeDetail, _$EnvelopeDetail];

  @override
  final String wireName = r'EnvelopeDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EnvelopeDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'line';
    yield serializers.serialize(
      object.line,
      specifiedType: const FullType(EnvelopeLine),
    );
    yield r'carryoverMinor';
    yield serializers.serialize(
      object.carryoverMinor,
      specifiedType: const FullType(int),
    );
    yield r'activity';
    yield serializers.serialize(
      object.activity,
      specifiedType: const FullType(BuiltList, [FullType(Transaction)]),
    );
    yield r'activityTotal';
    yield serializers.serialize(
      object.activityTotal,
      specifiedType: const FullType(int),
    );
    yield r'moves';
    yield serializers.serialize(
      object.moves,
      specifiedType: const FullType(BuiltList, [FullType(EnvelopeMove)]),
    );
    yield r'movesTotal';
    yield serializers.serialize(
      object.movesTotal,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EnvelopeDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EnvelopeDetailBuilder result,
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
        case r'line':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EnvelopeLine),
          ) as EnvelopeLine;
          result.line.replace(valueDes);
          break;
        case r'carryoverMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.carryoverMinor = valueDes;
          break;
        case r'activity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Transaction)]),
          ) as BuiltList<Transaction>;
          result.activity.replace(valueDes);
          break;
        case r'activityTotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.activityTotal = valueDes;
          break;
        case r'moves':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EnvelopeMove)]),
          ) as BuiltList<EnvelopeMove>;
          result.moves.replace(valueDes);
          break;
        case r'movesTotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.movesTotal = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EnvelopeDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EnvelopeDetailBuilder();
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


