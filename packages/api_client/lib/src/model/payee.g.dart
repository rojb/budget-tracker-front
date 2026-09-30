// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payee.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Payee extends Payee {
  @override
  final String id;
  @override
  final String name;
  @override
  final String? suggestedEnvelopeId;
  @override
  final int transactionCount;
  @override
  final bool deleted;
  @override
  final DateTime createdAt;

  factory _$Payee([void Function(PayeeBuilder)? updates]) =>
      (PayeeBuilder()..update(updates))._build();

  _$Payee._(
      {required this.id,
      required this.name,
      this.suggestedEnvelopeId,
      required this.transactionCount,
      required this.deleted,
      required this.createdAt})
      : super._();
  @override
  Payee rebuild(void Function(PayeeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PayeeBuilder toBuilder() => PayeeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Payee &&
        id == other.id &&
        name == other.name &&
        suggestedEnvelopeId == other.suggestedEnvelopeId &&
        transactionCount == other.transactionCount &&
        deleted == other.deleted &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, suggestedEnvelopeId.hashCode);
    _$hash = $jc(_$hash, transactionCount.hashCode);
    _$hash = $jc(_$hash, deleted.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Payee')
          ..add('id', id)
          ..add('name', name)
          ..add('suggestedEnvelopeId', suggestedEnvelopeId)
          ..add('transactionCount', transactionCount)
          ..add('deleted', deleted)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class PayeeBuilder implements Builder<Payee, PayeeBuilder> {
  _$Payee? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _suggestedEnvelopeId;
  String? get suggestedEnvelopeId => _$this._suggestedEnvelopeId;
  set suggestedEnvelopeId(String? suggestedEnvelopeId) =>
      _$this._suggestedEnvelopeId = suggestedEnvelopeId;

  int? _transactionCount;
  int? get transactionCount => _$this._transactionCount;
  set transactionCount(int? transactionCount) =>
      _$this._transactionCount = transactionCount;

  bool? _deleted;
  bool? get deleted => _$this._deleted;
  set deleted(bool? deleted) => _$this._deleted = deleted;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  PayeeBuilder() {
    Payee._defaults(this);
  }

  PayeeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _suggestedEnvelopeId = $v.suggestedEnvelopeId;
      _transactionCount = $v.transactionCount;
      _deleted = $v.deleted;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Payee other) {
    _$v = other as _$Payee;
  }

  @override
  void update(void Function(PayeeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Payee build() => _build();

  _$Payee _build() {
    final _$result = _$v ??
        _$Payee._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Payee', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(name, r'Payee', 'name'),
          suggestedEnvelopeId: suggestedEnvelopeId,
          transactionCount: BuiltValueNullFieldError.checkNotNull(
              transactionCount, r'Payee', 'transactionCount'),
          deleted: BuiltValueNullFieldError.checkNotNull(
              deleted, r'Payee', 'deleted'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Payee', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
