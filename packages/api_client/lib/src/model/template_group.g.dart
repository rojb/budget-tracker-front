// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TemplateGroup extends TemplateGroup {
  @override
  final String name;
  @override
  final BuiltList<TemplateEnvelope> envelopes;

  factory _$TemplateGroup([void Function(TemplateGroupBuilder)? updates]) =>
      (TemplateGroupBuilder()..update(updates))._build();

  _$TemplateGroup._({required this.name, required this.envelopes}) : super._();
  @override
  TemplateGroup rebuild(void Function(TemplateGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TemplateGroupBuilder toBuilder() => TemplateGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TemplateGroup &&
        name == other.name &&
        envelopes == other.envelopes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, envelopes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TemplateGroup')
          ..add('name', name)
          ..add('envelopes', envelopes))
        .toString();
  }
}

class TemplateGroupBuilder
    implements Builder<TemplateGroup, TemplateGroupBuilder> {
  _$TemplateGroup? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ListBuilder<TemplateEnvelope>? _envelopes;
  ListBuilder<TemplateEnvelope> get envelopes =>
      _$this._envelopes ??= ListBuilder<TemplateEnvelope>();
  set envelopes(ListBuilder<TemplateEnvelope>? envelopes) =>
      _$this._envelopes = envelopes;

  TemplateGroupBuilder() {
    TemplateGroup._defaults(this);
  }

  TemplateGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _envelopes = $v.envelopes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TemplateGroup other) {
    _$v = other as _$TemplateGroup;
  }

  @override
  void update(void Function(TemplateGroupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TemplateGroup build() => _build();

  _$TemplateGroup _build() {
    _$TemplateGroup _$result;
    try {
      _$result = _$v ??
          _$TemplateGroup._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'TemplateGroup', 'name'),
            envelopes: envelopes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'envelopes';
        envelopes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TemplateGroup', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
