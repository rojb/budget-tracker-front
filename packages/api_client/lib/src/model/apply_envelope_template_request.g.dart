// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_envelope_template_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApplyEnvelopeTemplateRequest extends ApplyEnvelopeTemplateRequest {
  @override
  final BuiltList<String>? envelopeNames;

  factory _$ApplyEnvelopeTemplateRequest(
          [void Function(ApplyEnvelopeTemplateRequestBuilder)? updates]) =>
      (ApplyEnvelopeTemplateRequestBuilder()..update(updates))._build();

  _$ApplyEnvelopeTemplateRequest._({this.envelopeNames}) : super._();
  @override
  ApplyEnvelopeTemplateRequest rebuild(
          void Function(ApplyEnvelopeTemplateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApplyEnvelopeTemplateRequestBuilder toBuilder() =>
      ApplyEnvelopeTemplateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApplyEnvelopeTemplateRequest &&
        envelopeNames == other.envelopeNames;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, envelopeNames.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApplyEnvelopeTemplateRequest')
          ..add('envelopeNames', envelopeNames))
        .toString();
  }
}

class ApplyEnvelopeTemplateRequestBuilder
    implements
        Builder<ApplyEnvelopeTemplateRequest,
            ApplyEnvelopeTemplateRequestBuilder> {
  _$ApplyEnvelopeTemplateRequest? _$v;

  ListBuilder<String>? _envelopeNames;
  ListBuilder<String> get envelopeNames =>
      _$this._envelopeNames ??= ListBuilder<String>();
  set envelopeNames(ListBuilder<String>? envelopeNames) =>
      _$this._envelopeNames = envelopeNames;

  ApplyEnvelopeTemplateRequestBuilder() {
    ApplyEnvelopeTemplateRequest._defaults(this);
  }

  ApplyEnvelopeTemplateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _envelopeNames = $v.envelopeNames?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApplyEnvelopeTemplateRequest other) {
    _$v = other as _$ApplyEnvelopeTemplateRequest;
  }

  @override
  void update(void Function(ApplyEnvelopeTemplateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApplyEnvelopeTemplateRequest build() => _build();

  _$ApplyEnvelopeTemplateRequest _build() {
    _$ApplyEnvelopeTemplateRequest _$result;
    try {
      _$result = _$v ??
          _$ApplyEnvelopeTemplateRequest._(
            envelopeNames: _envelopeNames?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'envelopeNames';
        _envelopeNames?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ApplyEnvelopeTemplateRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
