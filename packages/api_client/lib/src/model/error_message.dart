//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'dart:core';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'error_message.g.dart';

/// ErrorMessage
@BuiltValue()
abstract class ErrorMessage implements Built<ErrorMessage, ErrorMessageBuilder> {
  /// One Of [BuiltList<String>], [String]
  OneOf get oneOf;

  ErrorMessage._();

  factory ErrorMessage([void updates(ErrorMessageBuilder b)]) = _$ErrorMessage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ErrorMessageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ErrorMessage> get serializer => _$ErrorMessageSerializer();
}

class _$ErrorMessageSerializer implements PrimitiveSerializer<ErrorMessage> {
  @override
  final Iterable<Type> types = const [ErrorMessage, _$ErrorMessage];

  @override
  final String wireName = r'ErrorMessage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ErrorMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    ErrorMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  ErrorMessage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ErrorMessageBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(String), FullType(BuiltList, [FullType(String)]), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}


