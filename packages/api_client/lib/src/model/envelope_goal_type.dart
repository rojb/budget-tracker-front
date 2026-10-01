//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_goal_type.g.dart';

/// `monthly` is an amount to assign every month; `targetByDate` is an amount to have available by a due date.
class EnvelopeGoalType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'monthly')
  static const EnvelopeGoalType monthly = _$monthly;
  @BuiltValueEnumConst(wireName: r'targetByDate')
  static const EnvelopeGoalType targetByDate = _$targetByDate;

  static Serializer<EnvelopeGoalType> get serializer => _$envelopeGoalTypeSerializer;

  const EnvelopeGoalType._(String name): super(name);

  static BuiltSet<EnvelopeGoalType> get values => _$values;
  static EnvelopeGoalType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class EnvelopeGoalTypeMixin = Object with _$EnvelopeGoalTypeMixin;

