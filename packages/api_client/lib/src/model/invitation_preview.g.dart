// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InvitationPreview extends InvitationPreview {
  @override
  final String planName;
  @override
  final String ownerName;
  @override
  final Currency currency;
  @override
  final InvitationRole role;
  @override
  final DateTime expiresAt;

  factory _$InvitationPreview(
          [void Function(InvitationPreviewBuilder)? updates]) =>
      (InvitationPreviewBuilder()..update(updates))._build();

  _$InvitationPreview._(
      {required this.planName,
      required this.ownerName,
      required this.currency,
      required this.role,
      required this.expiresAt})
      : super._();
  @override
  InvitationPreview rebuild(void Function(InvitationPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvitationPreviewBuilder toBuilder() =>
      InvitationPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvitationPreview &&
        planName == other.planName &&
        ownerName == other.ownerName &&
        currency == other.currency &&
        role == other.role &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, planName.hashCode);
    _$hash = $jc(_$hash, ownerName.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvitationPreview')
          ..add('planName', planName)
          ..add('ownerName', ownerName)
          ..add('currency', currency)
          ..add('role', role)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class InvitationPreviewBuilder
    implements Builder<InvitationPreview, InvitationPreviewBuilder> {
  _$InvitationPreview? _$v;

  String? _planName;
  String? get planName => _$this._planName;
  set planName(String? planName) => _$this._planName = planName;

  String? _ownerName;
  String? get ownerName => _$this._ownerName;
  set ownerName(String? ownerName) => _$this._ownerName = ownerName;

  CurrencyBuilder? _currency;
  CurrencyBuilder get currency => _$this._currency ??= CurrencyBuilder();
  set currency(CurrencyBuilder? currency) => _$this._currency = currency;

  InvitationRole? _role;
  InvitationRole? get role => _$this._role;
  set role(InvitationRole? role) => _$this._role = role;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  InvitationPreviewBuilder() {
    InvitationPreview._defaults(this);
  }

  InvitationPreviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _planName = $v.planName;
      _ownerName = $v.ownerName;
      _currency = $v.currency.toBuilder();
      _role = $v.role;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvitationPreview other) {
    _$v = other as _$InvitationPreview;
  }

  @override
  void update(void Function(InvitationPreviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvitationPreview build() => _build();

  _$InvitationPreview _build() {
    _$InvitationPreview _$result;
    try {
      _$result = _$v ??
          _$InvitationPreview._(
            planName: BuiltValueNullFieldError.checkNotNull(
                planName, r'InvitationPreview', 'planName'),
            ownerName: BuiltValueNullFieldError.checkNotNull(
                ownerName, r'InvitationPreview', 'ownerName'),
            currency: currency.build(),
            role: BuiltValueNullFieldError.checkNotNull(
                role, r'InvitationPreview', 'role'),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
                expiresAt, r'InvitationPreview', 'expiresAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'currency';
        currency.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'InvitationPreview', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
