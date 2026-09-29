//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'validation_error.g.dart';

/// ValidationError
///
/// Properties:
/// * [statusCode] 
/// * [message] 
/// * [error] 
@BuiltValue()
abstract class ValidationError implements Built<ValidationError, ValidationErrorBuilder> {
  @BuiltValueField(wireName: r'statusCode')
  ValidationErrorStatusCodeEnum get statusCode;
  // enum statusCodeEnum {  400,  };

  @BuiltValueField(wireName: r'message')
  BuiltList<String> get message;

  @BuiltValueField(wireName: r'error')
  ValidationErrorErrorEnum get error;
  // enum errorEnum {  Bad Request,  };

  ValidationError._();

  factory ValidationError([void updates(ValidationErrorBuilder b)]) = _$ValidationError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ValidationErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ValidationError> get serializer => _$ValidationErrorSerializer();
}

class _$ValidationErrorSerializer implements PrimitiveSerializer<ValidationError> {
  @override
  final Iterable<Type> types = const [ValidationError, _$ValidationError];

  @override
  final String wireName = r'ValidationError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ValidationError object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'statusCode';
    yield serializers.serialize(
      object.statusCode,
      specifiedType: const FullType(ValidationErrorStatusCodeEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'error';
    yield serializers.serialize(
      object.error,
      specifiedType: const FullType(ValidationErrorErrorEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ValidationError object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ValidationErrorBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'statusCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ValidationErrorStatusCodeEnum),
          ) as ValidationErrorStatusCodeEnum;
          result.statusCode = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.message.replace(valueDes);
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ValidationErrorErrorEnum),
          ) as ValidationErrorErrorEnum;
          result.error = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ValidationError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ValidationErrorBuilder();
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


class ValidationErrorStatusCodeEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 400)
  static const ValidationErrorStatusCodeEnum number400 = _$validationErrorStatusCodeEnum_number400;

  static Serializer<ValidationErrorStatusCodeEnum> get serializer => _$validationErrorStatusCodeEnumSerializer;

  const ValidationErrorStatusCodeEnum._(String name): super(name);

  static BuiltSet<ValidationErrorStatusCodeEnum> get values => _$validationErrorStatusCodeEnumValues;
  static ValidationErrorStatusCodeEnum valueOf(String name) => _$validationErrorStatusCodeEnumValueOf(name);
}

class ValidationErrorErrorEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bad Request')
  static const ValidationErrorErrorEnum badRequest = _$validationErrorErrorEnum_badRequest;

  static Serializer<ValidationErrorErrorEnum> get serializer => _$validationErrorErrorEnumSerializer;

  const ValidationErrorErrorEnum._(String name): super(name);

  static BuiltSet<ValidationErrorErrorEnum> get values => _$validationErrorErrorEnumValues;
  static ValidationErrorErrorEnum valueOf(String name) => _$validationErrorErrorEnumValueOf(name);
}

