// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_transaction_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateTransactionRequest extends CreateTransactionRequest {
  @override
  final TransactionDirection direction;
  @override
  final String accountId;
  @override
  final int amountMinor;
  @override
  final DateTime occurredAt;
  @override
  final String? payeeId;
  @override
  final String? payeeName;
  @override
  final String? description;
  @override
  final String? envelopeId;
  @override
  final BuiltList<CreateTransactionSplit>? splits;

  factory _$CreateTransactionRequest(
          [void Function(CreateTransactionRequestBuilder)? updates]) =>
      (CreateTransactionRequestBuilder()..update(updates))._build();

  _$CreateTransactionRequest._(
      {required this.direction,
      required this.accountId,
      required this.amountMinor,
      required this.occurredAt,
      this.payeeId,
      this.payeeName,
      this.description,
      this.envelopeId,
      this.splits})
      : super._();
  @override
  CreateTransactionRequest rebuild(
          void Function(CreateTransactionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateTransactionRequestBuilder toBuilder() =>
      CreateTransactionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateTransactionRequest &&
        direction == other.direction &&
        accountId == other.accountId &&
        amountMinor == other.amountMinor &&
        occurredAt == other.occurredAt &&
        payeeId == other.payeeId &&
        payeeName == other.payeeName &&
        description == other.description &&
        envelopeId == other.envelopeId &&
        splits == other.splits;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, direction.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jc(_$hash, payeeId.hashCode);
    _$hash = $jc(_$hash, payeeName.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, envelopeId.hashCode);
    _$hash = $jc(_$hash, splits.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateTransactionRequest')
          ..add('direction', direction)
          ..add('accountId', accountId)
          ..add('amountMinor', amountMinor)
          ..add('occurredAt', occurredAt)
          ..add('payeeId', payeeId)
          ..add('payeeName', payeeName)
          ..add('description', description)
          ..add('envelopeId', envelopeId)
          ..add('splits', splits))
        .toString();
  }
}

class CreateTransactionRequestBuilder
    implements
        Builder<CreateTransactionRequest, CreateTransactionRequestBuilder> {
  _$CreateTransactionRequest? _$v;

  TransactionDirection? _direction;
  TransactionDirection? get direction => _$this._direction;
  set direction(TransactionDirection? direction) =>
      _$this._direction = direction;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  String? _payeeId;
  String? get payeeId => _$this._payeeId;
  set payeeId(String? payeeId) => _$this._payeeId = payeeId;

  String? _payeeName;
  String? get payeeName => _$this._payeeName;
  set payeeName(String? payeeName) => _$this._payeeName = payeeName;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _envelopeId;
  String? get envelopeId => _$this._envelopeId;
  set envelopeId(String? envelopeId) => _$this._envelopeId = envelopeId;

  ListBuilder<CreateTransactionSplit>? _splits;
  ListBuilder<CreateTransactionSplit> get splits =>
      _$this._splits ??= ListBuilder<CreateTransactionSplit>();
  set splits(ListBuilder<CreateTransactionSplit>? splits) =>
      _$this._splits = splits;

  CreateTransactionRequestBuilder() {
    CreateTransactionRequest._defaults(this);
  }

  CreateTransactionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _direction = $v.direction;
      _accountId = $v.accountId;
      _amountMinor = $v.amountMinor;
      _occurredAt = $v.occurredAt;
      _payeeId = $v.payeeId;
      _payeeName = $v.payeeName;
      _description = $v.description;
      _envelopeId = $v.envelopeId;
      _splits = $v.splits?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateTransactionRequest other) {
    _$v = other as _$CreateTransactionRequest;
  }

  @override
  void update(void Function(CreateTransactionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateTransactionRequest build() => _build();

  _$CreateTransactionRequest _build() {
    _$CreateTransactionRequest _$result;
    try {
      _$result = _$v ??
          _$CreateTransactionRequest._(
            direction: BuiltValueNullFieldError.checkNotNull(
                direction, r'CreateTransactionRequest', 'direction'),
            accountId: BuiltValueNullFieldError.checkNotNull(
                accountId, r'CreateTransactionRequest', 'accountId'),
            amountMinor: BuiltValueNullFieldError.checkNotNull(
                amountMinor, r'CreateTransactionRequest', 'amountMinor'),
            occurredAt: BuiltValueNullFieldError.checkNotNull(
                occurredAt, r'CreateTransactionRequest', 'occurredAt'),
            payeeId: payeeId,
            payeeName: payeeName,
            description: description,
            envelopeId: envelopeId,
            splits: _splits?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'splits';
        _splits?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateTransactionRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
