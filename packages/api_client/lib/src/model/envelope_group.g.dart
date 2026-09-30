// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnvelopeGroup extends EnvelopeGroup {
  @override
  final String id;
  @override
  final String name;
  @override
  final int position;
  @override
  final int envelopeCount;
  @override
  final DateTime createdAt;

  factory _$EnvelopeGroup([void Function(EnvelopeGroupBuilder)? updates]) =>
      (EnvelopeGroupBuilder()..update(updates))._build();

  _$EnvelopeGroup._(
      {required this.id,
      required this.name,
      required this.position,
      required this.envelopeCount,
      required this.createdAt})
      : super._();
  @override
  EnvelopeGroup rebuild(void Function(EnvelopeGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeGroupBuilder toBuilder() => EnvelopeGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnvelopeGroup &&
        id == other.id &&
        name == other.name &&
        position == other.position &&
        envelopeCount == other.envelopeCount &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, envelopeCount.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnvelopeGroup')
          ..add('id', id)
          ..add('name', name)
          ..add('position', position)
          ..add('envelopeCount', envelopeCount)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class EnvelopeGroupBuilder
    implements Builder<EnvelopeGroup, EnvelopeGroupBuilder> {
  _$EnvelopeGroup? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _position;
  int? get position => _$this._position;
  set position(int? position) => _$this._position = position;

  int? _envelopeCount;
  int? get envelopeCount => _$this._envelopeCount;
  set envelopeCount(int? envelopeCount) =>
      _$this._envelopeCount = envelopeCount;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  EnvelopeGroupBuilder() {
    EnvelopeGroup._defaults(this);
  }

  EnvelopeGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _position = $v.position;
      _envelopeCount = $v.envelopeCount;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnvelopeGroup other) {
    _$v = other as _$EnvelopeGroup;
  }

  @override
  void update(void Function(EnvelopeGroupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnvelopeGroup build() => _build();

  _$EnvelopeGroup _build() {
    final _$result = _$v ??
        _$EnvelopeGroup._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'EnvelopeGroup', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'EnvelopeGroup', 'name'),
          position: BuiltValueNullFieldError.checkNotNull(
              position, r'EnvelopeGroup', 'position'),
          envelopeCount: BuiltValueNullFieldError.checkNotNull(
              envelopeCount, r'EnvelopeGroup', 'envelopeCount'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'EnvelopeGroup', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
