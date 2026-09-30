// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Plan extends Plan {
  @override
  final String id;
  @override
  final String name;
  @override
  final Currency currency;
  @override
  final String timeZone;
  @override
  final PlanRole myRole;
  @override
  final BuiltList<PlanMember> members;
  @override
  final DateTime createdAt;

  factory _$Plan([void Function(PlanBuilder)? updates]) =>
      (PlanBuilder()..update(updates))._build();

  _$Plan._(
      {required this.id,
      required this.name,
      required this.currency,
      required this.timeZone,
      required this.myRole,
      required this.members,
      required this.createdAt})
      : super._();
  @override
  Plan rebuild(void Function(PlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlanBuilder toBuilder() => PlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Plan &&
        id == other.id &&
        name == other.name &&
        currency == other.currency &&
        timeZone == other.timeZone &&
        myRole == other.myRole &&
        members == other.members &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, timeZone.hashCode);
    _$hash = $jc(_$hash, myRole.hashCode);
    _$hash = $jc(_$hash, members.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Plan')
          ..add('id', id)
          ..add('name', name)
          ..add('currency', currency)
          ..add('timeZone', timeZone)
          ..add('myRole', myRole)
          ..add('members', members)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class PlanBuilder implements Builder<Plan, PlanBuilder> {
  _$Plan? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CurrencyBuilder? _currency;
  CurrencyBuilder get currency => _$this._currency ??= CurrencyBuilder();
  set currency(CurrencyBuilder? currency) => _$this._currency = currency;

  String? _timeZone;
  String? get timeZone => _$this._timeZone;
  set timeZone(String? timeZone) => _$this._timeZone = timeZone;

  PlanRole? _myRole;
  PlanRole? get myRole => _$this._myRole;
  set myRole(PlanRole? myRole) => _$this._myRole = myRole;

  ListBuilder<PlanMember>? _members;
  ListBuilder<PlanMember> get members =>
      _$this._members ??= ListBuilder<PlanMember>();
  set members(ListBuilder<PlanMember>? members) => _$this._members = members;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  PlanBuilder() {
    Plan._defaults(this);
  }

  PlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _currency = $v.currency.toBuilder();
      _timeZone = $v.timeZone;
      _myRole = $v.myRole;
      _members = $v.members.toBuilder();
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Plan other) {
    _$v = other as _$Plan;
  }

  @override
  void update(void Function(PlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Plan build() => _build();

  _$Plan _build() {
    _$Plan _$result;
    try {
      _$result = _$v ??
          _$Plan._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Plan', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(name, r'Plan', 'name'),
            currency: currency.build(),
            timeZone: BuiltValueNullFieldError.checkNotNull(
                timeZone, r'Plan', 'timeZone'),
            myRole: BuiltValueNullFieldError.checkNotNull(
                myRole, r'Plan', 'myRole'),
            members: members.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Plan', 'createdAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'currency';
        currency.build();

        _$failedField = 'members';
        members.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'Plan', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
