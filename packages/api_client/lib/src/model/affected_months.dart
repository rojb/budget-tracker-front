//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'affected_months.g.dart';

/// Months whose derived figures were recalculated by the change, ascending, in the plan's time zone: from the earliest month the transaction touched (before or after the change) to the later of the current month and the latest month it touched. 
///
/// Properties:
/// * [affectedMonths] 
@BuiltValue(instantiable: false)
abstract class AffectedMonths  {
  @BuiltValueField(wireName: r'affectedMonths')
  BuiltList<String> get affectedMonths;

  @BuiltValueSerializer(custom: true)
  static Serializer<AffectedMonths> get serializer => _$AffectedMonthsSerializer();
}

class _$AffectedMonthsSerializer implements PrimitiveSerializer<AffectedMonths> {
  @override
  final Iterable<Type> types = const [AffectedMonths];

  @override
  final String wireName = r'AffectedMonths';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AffectedMonths object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'affectedMonths';
    yield serializers.serialize(
      object.affectedMonths,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AffectedMonths object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  AffectedMonths deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($AffectedMonths)) as $AffectedMonths;
  }
}


/// a concrete implementation of [AffectedMonths], since [AffectedMonths] is not instantiable
@BuiltValue(instantiable: true)
abstract class $AffectedMonths implements AffectedMonths, Built<$AffectedMonths, $AffectedMonthsBuilder> {
  $AffectedMonths._();

  factory $AffectedMonths([void Function($AffectedMonthsBuilder)? updates]) = _$$AffectedMonths;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($AffectedMonthsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$AffectedMonths> get serializer => _$$AffectedMonthsSerializer();
}

class _$$AffectedMonthsSerializer implements PrimitiveSerializer<$AffectedMonths> {
  @override
  final Iterable<Type> types = const [$AffectedMonths, _$$AffectedMonths];

  @override
  final String wireName = r'$AffectedMonths';

  @override
  Object serialize(
    Serializers serializers,
    $AffectedMonths object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(AffectedMonths))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AffectedMonthsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'affectedMonths':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.affectedMonths.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $AffectedMonths deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $AffectedMonthsBuilder();
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

