// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_template.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnvelopeTemplate extends EnvelopeTemplate {
  @override
  final BuiltList<TemplateGroup> groups;

  factory _$EnvelopeTemplate(
          [void Function(EnvelopeTemplateBuilder)? updates]) =>
      (EnvelopeTemplateBuilder()..update(updates))._build();

  _$EnvelopeTemplate._({required this.groups}) : super._();
  @override
  EnvelopeTemplate rebuild(void Function(EnvelopeTemplateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeTemplateBuilder toBuilder() =>
      EnvelopeTemplateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnvelopeTemplate && groups == other.groups;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, groups.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnvelopeTemplate')
          ..add('groups', groups))
        .toString();
  }
}

class EnvelopeTemplateBuilder
    implements Builder<EnvelopeTemplate, EnvelopeTemplateBuilder> {
  _$EnvelopeTemplate? _$v;

  ListBuilder<TemplateGroup>? _groups;
  ListBuilder<TemplateGroup> get groups =>
      _$this._groups ??= ListBuilder<TemplateGroup>();
  set groups(ListBuilder<TemplateGroup>? groups) => _$this._groups = groups;

  EnvelopeTemplateBuilder() {
    EnvelopeTemplate._defaults(this);
  }

  EnvelopeTemplateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _groups = $v.groups.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnvelopeTemplate other) {
    _$v = other as _$EnvelopeTemplate;
  }

  @override
  void update(void Function(EnvelopeTemplateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnvelopeTemplate build() => _build();

  _$EnvelopeTemplate _build() {
    _$EnvelopeTemplate _$result;
    try {
      _$result = _$v ??
          _$EnvelopeTemplate._(
            groups: groups.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'groups';
        groups.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'EnvelopeTemplate', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
