// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_envelope.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TemplateEnvelope extends TemplateEnvelope {
  @override
  final String name;
  @override
  final EnvelopeIcon icon;

  factory _$TemplateEnvelope(
          [void Function(TemplateEnvelopeBuilder)? updates]) =>
      (TemplateEnvelopeBuilder()..update(updates))._build();

  _$TemplateEnvelope._({required this.name, required this.icon}) : super._();
  @override
  TemplateEnvelope rebuild(void Function(TemplateEnvelopeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TemplateEnvelopeBuilder toBuilder() =>
      TemplateEnvelopeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TemplateEnvelope &&
        name == other.name &&
        icon == other.icon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TemplateEnvelope')
          ..add('name', name)
          ..add('icon', icon))
        .toString();
  }
}

class TemplateEnvelopeBuilder
    implements Builder<TemplateEnvelope, TemplateEnvelopeBuilder> {
  _$TemplateEnvelope? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  EnvelopeIcon? _icon;
  EnvelopeIcon? get icon => _$this._icon;
  set icon(EnvelopeIcon? icon) => _$this._icon = icon;

  TemplateEnvelopeBuilder() {
    TemplateEnvelope._defaults(this);
  }

  TemplateEnvelopeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _icon = $v.icon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TemplateEnvelope other) {
    _$v = other as _$TemplateEnvelope;
  }

  @override
  void update(void Function(TemplateEnvelopeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TemplateEnvelope build() => _build();

  _$TemplateEnvelope _build() {
    final _$result = _$v ??
        _$TemplateEnvelope._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'TemplateEnvelope', 'name'),
          icon: BuiltValueNullFieldError.checkNotNull(
              icon, r'TemplateEnvelope', 'icon'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
