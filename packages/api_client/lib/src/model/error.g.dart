// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Error extends Error {
  @override
  final int statusCode;
  @override
  final ErrorMessage message;
  @override
  final String error;

  factory _$Error([void Function(ErrorBuilder)? updates]) =>
      (ErrorBuilder()..update(updates))._build();

  _$Error._(
      {required this.statusCode, required this.message, required this.error})
      : super._();
  @override
  Error rebuild(void Function(ErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorBuilder toBuilder() => ErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Error &&
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
    return (newBuiltValueToStringHelper(r'Error')
          ..add('statusCode', statusCode)
          ..add('message', message)
          ..add('error', error))
        .toString();
  }
}

class ErrorBuilder implements Builder<Error, ErrorBuilder> {
  _$Error? _$v;

  int? _statusCode;
  int? get statusCode => _$this._statusCode;
  set statusCode(int? statusCode) => _$this._statusCode = statusCode;

  ErrorMessageBuilder? _message;
  ErrorMessageBuilder get message => _$this._message ??= ErrorMessageBuilder();
  set message(ErrorMessageBuilder? message) => _$this._message = message;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  ErrorBuilder() {
    Error._defaults(this);
  }

  ErrorBuilder get _$this {
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
  void replace(Error other) {
    _$v = other as _$Error;
  }

  @override
  void update(void Function(ErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Error build() => _build();

  _$Error _build() {
    _$Error _$result;
    try {
      _$result = _$v ??
          _$Error._(
            statusCode: BuiltValueNullFieldError.checkNotNull(
                statusCode, r'Error', 'statusCode'),
            message: message.build(),
            error:
                BuiltValueNullFieldError.checkNotNull(error, r'Error', 'error'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'message';
        message.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'Error', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
