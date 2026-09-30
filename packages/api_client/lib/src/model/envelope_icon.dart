//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'envelope_icon.g.dart';

/// Closed set of icon names an envelope can carry; the client maps each to a glyph.
class EnvelopeIcon extends EnumClass {

  @BuiltValueEnumConst(wireName: r'tag')
  static const EnvelopeIcon tag = _$tag;
  @BuiltValueEnumConst(wireName: r'home')
  static const EnvelopeIcon home = _$home;
  @BuiltValueEnumConst(wireName: r'bus')
  static const EnvelopeIcon bus = _$bus;
  @BuiltValueEnumConst(wireName: r'utensils')
  static const EnvelopeIcon utensils = _$utensils;
  @BuiltValueEnumConst(wireName: r'heartPulse')
  static const EnvelopeIcon heartPulse = _$heartPulse;
  @BuiltValueEnumConst(wireName: r'gift')
  static const EnvelopeIcon gift = _$gift;
  @BuiltValueEnumConst(wireName: r'cart')
  static const EnvelopeIcon cart = _$cart;
  @BuiltValueEnumConst(wireName: r'pill')
  static const EnvelopeIcon pill = _$pill;
  @BuiltValueEnumConst(wireName: r'wifi')
  static const EnvelopeIcon wifi = _$wifi;
  @BuiltValueEnumConst(wireName: r'settings')
  static const EnvelopeIcon settings = _$settings;
  @BuiltValueEnumConst(wireName: r'ticket')
  static const EnvelopeIcon ticket = _$ticket;
  @BuiltValueEnumConst(wireName: r'repeat')
  static const EnvelopeIcon repeat = _$repeat;
  @BuiltValueEnumConst(wireName: r'lifeBuoy')
  static const EnvelopeIcon lifeBuoy = _$lifeBuoy;
  @BuiltValueEnumConst(wireName: r'plane')
  static const EnvelopeIcon plane = _$plane;

  static Serializer<EnvelopeIcon> get serializer => _$envelopeIconSerializer;

  const EnvelopeIcon._(String name): super(name);

  static BuiltSet<EnvelopeIcon> get values => _$values;
  static EnvelopeIcon valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class EnvelopeIconMixin = Object with _$EnvelopeIconMixin;

