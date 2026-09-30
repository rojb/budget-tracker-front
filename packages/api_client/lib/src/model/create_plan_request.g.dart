// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePlanRequest extends CreatePlanRequest {
  @override
  final String name;
  @override
  final CurrencyCode currencyCode;
  @override
  final String? timeZone;
  @override
  final CreateAccountRequest? firstAccount;

  factory _$CreatePlanRequest(
          [void Function(CreatePlanRequestBuilder)? updates]) =>
      (CreatePlanRequestBuilder()..update(updates))._build();

  _$CreatePlanRequest._(
      {required this.name,
      required this.currencyCode,
      this.timeZone,
      this.firstAccount})
      : super._();
  @override
  CreatePlanRequest rebuild(void Function(CreatePlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePlanRequestBuilder toBuilder() =>
      CreatePlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePlanRequest &&
        name == other.name &&
        currencyCode == other.currencyCode &&
        timeZone == other.timeZone &&
        firstAccount == other.firstAccount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, currencyCode.hashCode);
    _$hash = $jc(_$hash, timeZone.hashCode);
    _$hash = $jc(_$hash, firstAccount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePlanRequest')
          ..add('name', name)
          ..add('currencyCode', currencyCode)
          ..add('timeZone', timeZone)
          ..add('firstAccount', firstAccount))
        .toString();
  }
}

class CreatePlanRequestBuilder
    implements Builder<CreatePlanRequest, CreatePlanRequestBuilder> {
  _$CreatePlanRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CurrencyCode? _currencyCode;
  CurrencyCode? get currencyCode => _$this._currencyCode;
  set currencyCode(CurrencyCode? currencyCode) =>
      _$this._currencyCode = currencyCode;

  String? _timeZone;
  String? get timeZone => _$this._timeZone;
  set timeZone(String? timeZone) => _$this._timeZone = timeZone;

  CreateAccountRequestBuilder? _firstAccount;
  CreateAccountRequestBuilder get firstAccount =>
      _$this._firstAccount ??= CreateAccountRequestBuilder();
  set firstAccount(CreateAccountRequestBuilder? firstAccount) =>
      _$this._firstAccount = firstAccount;

  CreatePlanRequestBuilder() {
    CreatePlanRequest._defaults(this);
  }

  CreatePlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _currencyCode = $v.currencyCode;
      _timeZone = $v.timeZone;
      _firstAccount = $v.firstAccount?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePlanRequest other) {
    _$v = other as _$CreatePlanRequest;
  }

  @override
  void update(void Function(CreatePlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePlanRequest build() => _build();

  _$CreatePlanRequest _build() {
    _$CreatePlanRequest _$result;
    try {
      _$result = _$v ??
          _$CreatePlanRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CreatePlanRequest', 'name'),
            currencyCode: BuiltValueNullFieldError.checkNotNull(
                currencyCode, r'CreatePlanRequest', 'currencyCode'),
            timeZone: timeZone,
            firstAccount: _firstAccount?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'firstAccount';
        _firstAccount?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreatePlanRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
