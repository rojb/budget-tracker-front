// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_envelope_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateEnvelopeRequest extends CreateEnvelopeRequest {
  @override
  final String name;
  @override
  final String? groupId;
  @override
  final EnvelopeIcon? icon;

  factory _$CreateEnvelopeRequest(
          [void Function(CreateEnvelopeRequestBuilder)? updates]) =>
      (CreateEnvelopeRequestBuilder()..update(updates))._build();

  _$CreateEnvelopeRequest._({required this.name, this.groupId, this.icon})
      : super._();
  @override
  CreateEnvelopeRequest rebuild(
          void Function(CreateEnvelopeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateEnvelopeRequestBuilder toBuilder() =>
      CreateEnvelopeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateEnvelopeRequest &&
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
    return (newBuiltValueToStringHelper(r'CreateEnvelopeRequest')
          ..add('name', name)
          ..add('groupId', groupId)
          ..add('icon', icon))
        .toString();
  }
}

class CreateEnvelopeRequestBuilder
    implements Builder<CreateEnvelopeRequest, CreateEnvelopeRequestBuilder> {
  _$CreateEnvelopeRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _groupId;
  String? get groupId => _$this._groupId;
  set groupId(String? groupId) => _$this._groupId = groupId;

  EnvelopeIcon? _icon;
  EnvelopeIcon? get icon => _$this._icon;
  set icon(EnvelopeIcon? icon) => _$this._icon = icon;

  CreateEnvelopeRequestBuilder() {
    CreateEnvelopeRequest._defaults(this);
  }

  CreateEnvelopeRequestBuilder get _$this {
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
  void replace(CreateEnvelopeRequest other) {
    _$v = other as _$CreateEnvelopeRequest;
  }

  @override
  void update(void Function(CreateEnvelopeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateEnvelopeRequest build() => _build();

  _$CreateEnvelopeRequest _build() {
    final _$result = _$v ??
        _$CreateEnvelopeRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CreateEnvelopeRequest', 'name'),
          groupId: groupId,
          icon: icon,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
