// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_envelope_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateEnvelopeRequest extends UpdateEnvelopeRequest {
  @override
  final String? name;
  @override
  final String? groupId;
  @override
  final EnvelopeIcon? icon;

  factory _$UpdateEnvelopeRequest(
          [void Function(UpdateEnvelopeRequestBuilder)? updates]) =>
      (UpdateEnvelopeRequestBuilder()..update(updates))._build();

  _$UpdateEnvelopeRequest._({this.name, this.groupId, this.icon}) : super._();
  @override
  UpdateEnvelopeRequest rebuild(
          void Function(UpdateEnvelopeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateEnvelopeRequestBuilder toBuilder() =>
      UpdateEnvelopeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateEnvelopeRequest &&
        name == other.name &&
        groupId == other.groupId &&
        icon == other.icon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateEnvelopeRequest')
          ..add('name', name)
          ..add('groupId', groupId)
          ..add('icon', icon))
        .toString();
  }
}

class UpdateEnvelopeRequestBuilder
    implements Builder<UpdateEnvelopeRequest, UpdateEnvelopeRequestBuilder> {
  _$UpdateEnvelopeRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _groupId;
  String? get groupId => _$this._groupId;
  set groupId(String? groupId) => _$this._groupId = groupId;

  EnvelopeIcon? _icon;
  EnvelopeIcon? get icon => _$this._icon;
  set icon(EnvelopeIcon? icon) => _$this._icon = icon;

  UpdateEnvelopeRequestBuilder() {
    UpdateEnvelopeRequest._defaults(this);
  }

  UpdateEnvelopeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _groupId = $v.groupId;
      _icon = $v.icon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateEnvelopeRequest other) {
    _$v = other as _$UpdateEnvelopeRequest;
  }

  @override
  void update(void Function(UpdateEnvelopeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateEnvelopeRequest build() => _build();

  _$UpdateEnvelopeRequest _build() {
    final _$result = _$v ??
        _$UpdateEnvelopeRequest._(
          name: name,
          groupId: groupId,
          icon: icon,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
