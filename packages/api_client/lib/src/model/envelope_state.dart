//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_state.g.dart';

/// Derived state of an envelope in a month, computed only by the API: `overspent` when its Available is negative; otherwise `underfunded` when it has a goal and the amount assigned in the month is lower than the required amount; otherwise `funded`. 
class EnvelopeState extends EnumClass {

  @BuiltValueEnumConst(wireName: r'funded')
  static const EnvelopeState funded = _$funded;
  @BuiltValueEnumConst(wireName: r'underfunded')
  static const EnvelopeState underfunded = _$underfunded;
  @BuiltValueEnumConst(wireName: r'overspent')
  static const EnvelopeState overspent = _$overspent;

  static Serializer<EnvelopeState> get serializer => _$envelopeStateSerializer;

  const EnvelopeState._(String name): super(name);

  static BuiltSet<EnvelopeState> get values => _$values;
  static EnvelopeState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class EnvelopeStateMixin = Object with _$EnvelopeStateMixin;

