// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ErrorMessage extends ErrorMessage {
  @override
  final OneOf oneOf;

  factory _$ErrorMessage([void Function(ErrorMessageBuilder)? updates]) =>
      (ErrorMessageBuilder()..update(updates))._build();

  _$ErrorMessage._({required this.oneOf}) : super._();
  @override
  ErrorMessage rebuild(void Function(ErrorMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorMessageBuilder toBuilder() => ErrorMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorMessage && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorMessage')..add('oneOf', oneOf))
        .toString();
  }
}

class ErrorMessageBuilder
    implements Builder<ErrorMessage, ErrorMessageBuilder> {
  _$ErrorMessage? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  ErrorMessageBuilder() {
    ErrorMessage._defaults(this);
  }

  ErrorMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorMessage other) {
    _$v = other as _$ErrorMessage;
  }

  @override
  void update(void Function(ErrorMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorMessage build() => _build();

  _$ErrorMessage _build() {
    final _$result = _$v ??
        _$ErrorMessage._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'ErrorMessage', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
