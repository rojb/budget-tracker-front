//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/close_line.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'month_close.g.dart';

/// The close of a month into the next one (FR-12).
///
/// Properties:
/// * [fromMonth] - Budget month as YYYY-MM.
/// * [toMonth] - Budget month as YYYY-MM.
/// * [carried] - Envelopes whose positive Available carries into the next month.
/// * [deducted] - Overspent envelopes, deducted from the next month's Ready to Assign; they restart at 0.
/// * [totalDeductedMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [readyToAssignFromMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [readyToAssignToMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [balanceMinor] - Σ account balances at the end of the next month.
/// * [availableMinor] - Σ Available of the next month.
/// * [futureAssignedMinor] - Σ Assigned after the next month; balance − available − this = readyToAssignTo.
/// * [confirmed] - True once an owner or editor confirmed the close.
@BuiltValue()
abstract class MonthClose implements Built<MonthClose, MonthCloseBuilder> {
  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'fromMonth')
  String get fromMonth;

  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'toMonth')
  String get toMonth;

  /// Envelopes whose positive Available carries into the next month.
  @BuiltValueField(wireName: r'carried')
  BuiltList<CloseLine> get carried;

  /// Overspent envelopes, deducted from the next month's Ready to Assign; they restart at 0.
  @BuiltValueField(wireName: r'deducted')
  BuiltList<CloseLine> get deducted;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'totalDeductedMinor')
  int get totalDeductedMinor;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'readyToAssignFromMinor')
  int get readyToAssignFromMinor;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'readyToAssignToMinor')
  int get readyToAssignToMinor;

  /// Σ account balances at the end of the next month.
  @BuiltValueField(wireName: r'balanceMinor')
  int get balanceMinor;

  /// Σ Available of the next month.
  @BuiltValueField(wireName: r'availableMinor')
  int get availableMinor;

  /// Σ Assigned after the next month; balance − available − this = readyToAssignTo.
  @BuiltValueField(wireName: r'futureAssignedMinor')
  int get futureAssignedMinor;

  /// True once an owner or editor confirmed the close.
  @BuiltValueField(wireName: r'confirmed')
  bool get confirmed;

  MonthClose._();

  factory MonthClose([void updates(MonthCloseBuilder b)]) = _$MonthClose;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MonthCloseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MonthClose> get serializer => _$MonthCloseSerializer();
}

class _$MonthCloseSerializer implements PrimitiveSerializer<MonthClose> {
  @override
  final Iterable<Type> types = const [MonthClose, _$MonthClose];

  @override
  final String wireName = r'MonthClose';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MonthClose object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'fromMonth';
    yield serializers.serialize(
      object.fromMonth,
      specifiedType: const FullType(String),
    );
    yield r'toMonth';
    yield serializers.serialize(
      object.toMonth,
      specifiedType: const FullType(String),
    );
    yield r'carried';
    yield serializers.serialize(
      object.carried,
      specifiedType: const FullType(BuiltList, [FullType(CloseLine)]),
    );
    yield r'deducted';
    yield serializers.serialize(
      object.deducted,
      specifiedType: const FullType(BuiltList, [FullType(CloseLine)]),
    );
    yield r'totalDeductedMinor';
    yield serializers.serialize(
      object.totalDeductedMinor,
      specifiedType: const FullType(int),
    );
    yield r'readyToAssignFromMinor';
    yield serializers.serialize(
      object.readyToAssignFromMinor,
      specifiedType: const FullType(int),
    );
    yield r'readyToAssignToMinor';
    yield serializers.serialize(
      object.readyToAssignToMinor,
      specifiedType: const FullType(int),
    );
    yield r'balanceMinor';
    yield serializers.serialize(
      object.balanceMinor,
      specifiedType: const FullType(int),
    );
    yield r'availableMinor';
    yield serializers.serialize(
      object.availableMinor,
      specifiedType: const FullType(int),
    );
    yield r'futureAssignedMinor';
    yield serializers.serialize(
      object.futureAssignedMinor,
      specifiedType: const FullType(int),
    );
    yield r'confirmed';
    yield serializers.serialize(
      object.confirmed,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MonthClose object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MonthCloseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fromMonth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fromMonth = valueDes;
          break;
        case r'toMonth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.toMonth = valueDes;
          break;
        case r'carried':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CloseLine)]),
          ) as BuiltList<CloseLine>;
          result.carried.replace(valueDes);
          break;
        case r'deducted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CloseLine)]),
          ) as BuiltList<CloseLine>;
          result.deducted.replace(valueDes);
          break;
        case r'totalDeductedMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalDeductedMinor = valueDes;
          break;
        case r'readyToAssignFromMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.readyToAssignFromMinor = valueDes;
          break;
        case r'readyToAssignToMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.readyToAssignToMinor = valueDes;
          break;
        case r'balanceMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.balanceMinor = valueDes;
          break;
        case r'availableMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.availableMinor = valueDes;
          break;
        case r'futureAssignedMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.futureAssignedMinor = valueDes;
          break;
        case r'confirmed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.confirmed = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MonthClose deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MonthCloseBuilder();
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


