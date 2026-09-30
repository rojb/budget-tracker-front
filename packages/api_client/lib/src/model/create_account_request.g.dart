// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAccountRequest extends CreateAccountRequest {
  @override
  final String name;
  @override
  final AccountType type;
  @override
  final int openingBalanceMinor;

  factory _$CreateAccountRequest(
          [void Function(CreateAccountRequestBuilder)? updates]) =>
      (CreateAccountRequestBuilder()..update(updates))._build();

  _$CreateAccountRequest._(
      {required this.name,
      required this.type,
      required this.openingBalanceMinor})
      : super._();
  @override
  CreateAccountRequest rebuild(
          void Function(CreateAccountRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAccountRequestBuilder toBuilder() =>
      CreateAccountRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAccountRequest &&
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
    return (newBuiltValueToStringHelper(r'CreateAccountRequest')
          ..add('name', name)
          ..add('type', type)
          ..add('openingBalanceMinor', openingBalanceMinor))
        .toString();
  }
}

class CreateAccountRequestBuilder
    implements Builder<CreateAccountRequest, CreateAccountRequestBuilder> {
  _$CreateAccountRequest? _$v;

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

  CreateAccountRequestBuilder() {
    CreateAccountRequest._defaults(this);
  }

  CreateAccountRequestBuilder get _$this {
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
  void replace(CreateAccountRequest other) {
    _$v = other as _$CreateAccountRequest;
  }

  @override
  void update(void Function(CreateAccountRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAccountRequest build() => _build();

  _$CreateAccountRequest _build() {
    final _$result = _$v ??
        _$CreateAccountRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CreateAccountRequest', 'name'),
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'CreateAccountRequest', 'type'),
          openingBalanceMinor: BuiltValueNullFieldError.checkNotNull(
              openingBalanceMinor,
              r'CreateAccountRequest',
              'openingBalanceMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
