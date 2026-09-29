//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'currency_code.g.dart';

/// Currency of a plan. Chosen at plan creation and immutable afterwards (FR-40).
class CurrencyCode extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ARS')
  static const CurrencyCode ARS = _$ARS;
  @BuiltValueEnumConst(wireName: r'USD')
  static const CurrencyCode USD = _$USD;
  @BuiltValueEnumConst(wireName: r'EUR')
  static const CurrencyCode EUR = _$EUR;

  static Serializer<CurrencyCode> get serializer => _$currencyCodeSerializer;

  const CurrencyCode._(String name): super(name);

  static BuiltSet<CurrencyCode> get values => _$values;
  static CurrencyCode valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class CurrencyCodeMixin = Object with _$CurrencyCodeMixin;

