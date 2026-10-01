// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_spending.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnvelopeSpending extends EnvelopeSpending {
  @override
  final String envelopeId;
  @override
  final String name;
  @override
  final EnvelopeIcon icon;
  @override
  final int amountMinor;

  factory _$EnvelopeSpending(
          [void Function(EnvelopeSpendingBuilder)? updates]) =>
      (EnvelopeSpendingBuilder()..update(updates))._build();

  _$EnvelopeSpending._(
      {required this.envelopeId,
      required this.name,
      required this.icon,
      required this.amountMinor})
      : super._();
  @override
  EnvelopeSpending rebuild(void Function(EnvelopeSpendingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeSpendingBuilder toBuilder() =>
      EnvelopeSpendingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnvelopeSpending &&
        envelopeId == other.envelopeId &&
        name == other.name &&
        icon == other.icon &&
        amountMinor == other.amountMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, envelopeId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnvelopeSpending')
          ..add('envelopeId', envelopeId)
          ..add('name', name)
          ..add('icon', icon)
          ..add('amountMinor', amountMinor))
        .toString();
  }
}

class EnvelopeSpendingBuilder
    implements Builder<EnvelopeSpending, EnvelopeSpendingBuilder> {
  _$EnvelopeSpending? _$v;

  String? _envelopeId;
  String? get envelopeId => _$this._envelopeId;
  set envelopeId(String? envelopeId) => _$this._envelopeId = envelopeId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  EnvelopeIcon? _icon;
  EnvelopeIcon? get icon => _$this._icon;
  set icon(EnvelopeIcon? icon) => _$this._icon = icon;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  EnvelopeSpendingBuilder() {
    EnvelopeSpending._defaults(this);
  }

  EnvelopeSpendingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _envelopeId = $v.envelopeId;
      _name = $v.name;
      _icon = $v.icon;
      _amountMinor = $v.amountMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnvelopeSpending other) {
    _$v = other as _$EnvelopeSpending;
  }

  @override
  void update(void Function(EnvelopeSpendingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnvelopeSpending build() => _build();

  _$EnvelopeSpending _build() {
    final _$result = _$v ??
        _$EnvelopeSpending._(
          envelopeId: BuiltValueNullFieldError.checkNotNull(
              envelopeId, r'EnvelopeSpending', 'envelopeId'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'EnvelopeSpending', 'name'),
          icon: BuiltValueNullFieldError.checkNotNull(
              icon, r'EnvelopeSpending', 'icon'),
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'EnvelopeSpending', 'amountMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
