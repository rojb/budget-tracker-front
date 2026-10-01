// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Envelope extends Envelope {
  @override
  final String id;
  @override
  final String name;
  @override
  final EnvelopeIcon icon;
  @override
  final String? groupId;
  @override
  final int position;
  @override
  final EnvelopeGoal? goal;
  @override
  final String? photoUrl;
  @override
  final DateTime createdAt;

  factory _$Envelope([void Function(EnvelopeBuilder)? updates]) =>
      (EnvelopeBuilder()..update(updates))._build();

  _$Envelope._(
      {required this.id,
      required this.name,
      required this.icon,
      this.groupId,
      required this.position,
      this.goal,
      this.photoUrl,
      required this.createdAt})
      : super._();
  @override
  Envelope rebuild(void Function(EnvelopeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeBuilder toBuilder() => EnvelopeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Envelope &&
        id == other.id &&
        name == other.name &&
        icon == other.icon &&
        groupId == other.groupId &&
        position == other.position &&
        goal == other.goal &&
        photoUrl == other.photoUrl &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, goal.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Envelope')
          ..add('id', id)
          ..add('name', name)
          ..add('icon', icon)
          ..add('groupId', groupId)
          ..add('position', position)
          ..add('goal', goal)
          ..add('photoUrl', photoUrl)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class EnvelopeBuilder implements Builder<Envelope, EnvelopeBuilder> {
  _$Envelope? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  EnvelopeIcon? _icon;
  EnvelopeIcon? get icon => _$this._icon;
  set icon(EnvelopeIcon? icon) => _$this._icon = icon;

  String? _groupId;
  String? get groupId => _$this._groupId;
  set groupId(String? groupId) => _$this._groupId = groupId;

  int? _position;
  int? get position => _$this._position;
  set position(int? position) => _$this._position = position;

  EnvelopeGoalBuilder? _goal;
  EnvelopeGoalBuilder get goal => _$this._goal ??= EnvelopeGoalBuilder();
  set goal(EnvelopeGoalBuilder? goal) => _$this._goal = goal;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  EnvelopeBuilder() {
    Envelope._defaults(this);
  }

  EnvelopeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _icon = $v.icon;
      _groupId = $v.groupId;
      _position = $v.position;
      _goal = $v.goal?.toBuilder();
      _photoUrl = $v.photoUrl;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Envelope other) {
    _$v = other as _$Envelope;
  }

  @override
  void update(void Function(EnvelopeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Envelope build() => _build();

  _$Envelope _build() {
    _$Envelope _$result;
    try {
      _$result = _$v ??
          _$Envelope._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Envelope', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'Envelope', 'name'),
            icon: BuiltValueNullFieldError.checkNotNull(
                icon, r'Envelope', 'icon'),
            groupId: groupId,
            position: BuiltValueNullFieldError.checkNotNull(
                position, r'Envelope', 'position'),
            goal: _goal?.build(),
            photoUrl: photoUrl,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Envelope', 'createdAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'goal';
        _goal?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Envelope', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
