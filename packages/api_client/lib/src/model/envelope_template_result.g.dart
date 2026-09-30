// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_template_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnvelopeTemplateResult extends EnvelopeTemplateResult {
  @override
  final BuiltList<EnvelopeGroup> groups;
  @override
  final BuiltList<Envelope> envelopes;

  factory _$EnvelopeTemplateResult(
          [void Function(EnvelopeTemplateResultBuilder)? updates]) =>
      (EnvelopeTemplateResultBuilder()..update(updates))._build();

  _$EnvelopeTemplateResult._({required this.groups, required this.envelopes})
      : super._();
  @override
  EnvelopeTemplateResult rebuild(
          void Function(EnvelopeTemplateResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeTemplateResultBuilder toBuilder() =>
      EnvelopeTemplateResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnvelopeTemplateResult &&
        groups == other.groups &&
        envelopes == other.envelopes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, groups.hashCode);
    _$hash = $jc(_$hash, envelopes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnvelopeTemplateResult')
          ..add('groups', groups)
          ..add('envelopes', envelopes))
        .toString();
  }
}

class EnvelopeTemplateResultBuilder
    implements Builder<EnvelopeTemplateResult, EnvelopeTemplateResultBuilder> {
  _$EnvelopeTemplateResult? _$v;

  ListBuilder<EnvelopeGroup>? _groups;
  ListBuilder<EnvelopeGroup> get groups =>
      _$this._groups ??= ListBuilder<EnvelopeGroup>();
  set groups(ListBuilder<EnvelopeGroup>? groups) => _$this._groups = groups;

  ListBuilder<Envelope>? _envelopes;
  ListBuilder<Envelope> get envelopes =>
      _$this._envelopes ??= ListBuilder<Envelope>();
  set envelopes(ListBuilder<Envelope>? envelopes) =>
      _$this._envelopes = envelopes;

  EnvelopeTemplateResultBuilder() {
    EnvelopeTemplateResult._defaults(this);
  }

  EnvelopeTemplateResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _groups = $v.groups.toBuilder();
      _envelopes = $v.envelopes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnvelopeTemplateResult other) {
    _$v = other as _$EnvelopeTemplateResult;
  }

  @override
  void update(void Function(EnvelopeTemplateResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnvelopeTemplateResult build() => _build();

  _$EnvelopeTemplateResult _build() {
    _$EnvelopeTemplateResult _$result;
    try {
      _$result = _$v ??
          _$EnvelopeTemplateResult._(
            groups: groups.build(),
            envelopes: envelopes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'groups';
        groups.build();
        _$failedField = 'envelopes';
        envelopes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'EnvelopeTemplateResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
