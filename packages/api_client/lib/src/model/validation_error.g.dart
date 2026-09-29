// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ValidationErrorStatusCodeEnum _$validationErrorStatusCodeEnum_number400 =
    const ValidationErrorStatusCodeEnum._('number400');

ValidationErrorStatusCodeEnum _$validationErrorStatusCodeEnumValueOf(
    String name) {
  switch (name) {
    case 'number400':
      return _$validationErrorStatusCodeEnum_number400;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ValidationErrorStatusCodeEnum>
    _$validationErrorStatusCodeEnumValues = BuiltSet<
        ValidationErrorStatusCodeEnum>(const <ValidationErrorStatusCodeEnum>[
  _$validationErrorStatusCodeEnum_number400,
]);

const ValidationErrorErrorEnum _$validationErrorErrorEnum_badRequest =
    const ValidationErrorErrorEnum._('badRequest');

ValidationErrorErrorEnum _$validationErrorErrorEnumValueOf(String name) {
  switch (name) {
    case 'badRequest':
      return _$validationErrorErrorEnum_badRequest;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ValidationErrorErrorEnum> _$validationErrorErrorEnumValues =
    BuiltSet<ValidationErrorErrorEnum>(const <ValidationErrorErrorEnum>[
  _$validationErrorErrorEnum_badRequest,
]);

Serializer<ValidationErrorStatusCodeEnum>
    _$validationErrorStatusCodeEnumSerializer =
    _$ValidationErrorStatusCodeEnumSerializer();
Serializer<ValidationErrorErrorEnum> _$validationErrorErrorEnumSerializer =
    _$ValidationErrorErrorEnumSerializer();

class _$ValidationErrorStatusCodeEnumSerializer
    implements PrimitiveSerializer<ValidationErrorStatusCodeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number400': 400,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    400: 'number400',
  };

  @override
  final Iterable<Type> types = const <Type>[ValidationErrorStatusCodeEnum];
  @override
  final String wireName = 'ValidationErrorStatusCodeEnum';

  @override
  Object serialize(
          Serializers serializers, ValidationErrorStatusCodeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ValidationErrorStatusCodeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ValidationErrorStatusCodeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ValidationErrorErrorEnumSerializer
    implements PrimitiveSerializer<ValidationErrorErrorEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'badRequest': 'Bad Request',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Bad Request': 'badRequest',
  };

  @override
  final Iterable<Type> types = const <Type>[ValidationErrorErrorEnum];
  @override
  final String wireName = 'ValidationErrorErrorEnum';

  @override
  Object serialize(Serializers serializers, ValidationErrorErrorEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ValidationErrorErrorEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ValidationErrorErrorEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ValidationError extends ValidationError {
  @override
  final ValidationErrorStatusCodeEnum statusCode;
  @override
  final BuiltList<String> message;
  @override
  final ValidationErrorErrorEnum error;

  factory _$ValidationError([void Function(ValidationErrorBuilder)? updates]) =>
      (ValidationErrorBuilder()..update(updates))._build();

  _$ValidationError._(
      {required this.statusCode, required this.message, required this.error})
      : super._();
  @override
  ValidationError rebuild(void Function(ValidationErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ValidationErrorBuilder toBuilder() => ValidationErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ValidationError &&
        statusCode == other.statusCode &&
        message == other.message &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, statusCode.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ValidationError')
          ..add('statusCode', statusCode)
          ..add('message', message)
          ..add('error', error))
        .toString();
  }
}

class ValidationErrorBuilder
    implements Builder<ValidationError, ValidationErrorBuilder> {
  _$ValidationError? _$v;

  ValidationErrorStatusCodeEnum? _statusCode;
  ValidationErrorStatusCodeEnum? get statusCode => _$this._statusCode;
  set statusCode(ValidationErrorStatusCodeEnum? statusCode) =>
      _$this._statusCode = statusCode;

  ListBuilder<String>? _message;
  ListBuilder<String> get message => _$this._message ??= ListBuilder<String>();
  set message(ListBuilder<String>? message) => _$this._message = message;

  ValidationErrorErrorEnum? _error;
  ValidationErrorErrorEnum? get error => _$this._error;
  set error(ValidationErrorErrorEnum? error) => _$this._error = error;

  ValidationErrorBuilder() {
    ValidationError._defaults(this);
  }

  ValidationErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _statusCode = $v.statusCode;
      _message = $v.message.toBuilder();
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ValidationError other) {
    _$v = other as _$ValidationError;
  }

  @override
  void update(void Function(ValidationErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ValidationError build() => _build();

  _$ValidationError _build() {
    _$ValidationError _$result;
    try {
      _$result = _$v ??
          _$ValidationError._(
            statusCode: BuiltValueNullFieldError.checkNotNull(
                statusCode, r'ValidationError', 'statusCode'),
            message: message.build(),
            error: BuiltValueNullFieldError.checkNotNull(
                error, r'ValidationError', 'error'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'message';
        message.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ValidationError', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
