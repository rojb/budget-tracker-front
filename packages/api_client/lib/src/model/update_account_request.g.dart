// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAccountRequest extends UpdateAccountRequest {
  @override
  final String? name;
  @override
  final AccountType? type;
  @override
  final int? openingBalanceMinor;

  factory _$UpdateAccountRequest(
          [void Function(UpdateAccountRequestBuilder)? updates]) =>
      (UpdateAccountRequestBuilder()..update(updates))._build();

  _$UpdateAccountRequest._({this.name, this.type, this.openingBalanceMinor})
      : super._();
  @override
  UpdateAccountRequest rebuild(
          void Function(UpdateAccountRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateAccountRequestBuilder toBuilder() =>
      UpdateAccountRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAccountRequest &&
        name == other.name &&
        type == other.type &&
        openingBalanceMinor == other.openingBalanceMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, openingBalanceMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAccountRequest')
          ..add('name', name)
          ..add('type', type)
          ..add('openingBalanceMinor', openingBalanceMinor))
        .toString();
  }
}

class UpdateAccountRequestBuilder
    implements Builder<UpdateAccountRequest, UpdateAccountRequestBuilder> {
  _$UpdateAccountRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  AccountType? _type;
  AccountType? get type => _$this._type;
  set type(AccountType? type) => _$this._type = type;

  int? _openingBalanceMinor;
  int? get openingBalanceMinor => _$this._openingBalanceMinor;
  set openingBalanceMinor(int? openingBalanceMinor) =>
      _$this._openingBalanceMinor = openingBalanceMinor;

  UpdateAccountRequestBuilder() {
    UpdateAccountRequest._defaults(this);
  }

  UpdateAccountRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _type = $v.type;
      _openingBalanceMinor = $v.openingBalanceMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAccountRequest other) {
    _$v = other as _$UpdateAccountRequest;
  }

  @override
  void update(void Function(UpdateAccountRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAccountRequest build() => _build();

  _$UpdateAccountRequest _build() {
    final _$result = _$v ??
        _$UpdateAccountRequest._(
          name: name,
          type: type,
          openingBalanceMinor: openingBalanceMinor,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
