// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_envelope_group_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateEnvelopeGroupRequest extends UpdateEnvelopeGroupRequest {
  @override
  final String name;

  factory _$UpdateEnvelopeGroupRequest(
          [void Function(UpdateEnvelopeGroupRequestBuilder)? updates]) =>
      (UpdateEnvelopeGroupRequestBuilder()..update(updates))._build();

  _$UpdateEnvelopeGroupRequest._({required this.name}) : super._();
  @override
  UpdateEnvelopeGroupRequest rebuild(
          void Function(UpdateEnvelopeGroupRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateEnvelopeGroupRequestBuilder toBuilder() =>
      UpdateEnvelopeGroupRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateEnvelopeGroupRequest && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateEnvelopeGroupRequest')
          ..add('name', name))
        .toString();
  }
}

class UpdateEnvelopeGroupRequestBuilder
    implements
        Builder<UpdateEnvelopeGroupRequest, UpdateEnvelopeGroupRequestBuilder> {
  _$UpdateEnvelopeGroupRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  UpdateEnvelopeGroupRequestBuilder() {
    UpdateEnvelopeGroupRequest._defaults(this);
  }

  UpdateEnvelopeGroupRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateEnvelopeGroupRequest other) {
    _$v = other as _$UpdateEnvelopeGroupRequest;
  }

  @override
  void update(void Function(UpdateEnvelopeGroupRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateEnvelopeGroupRequest build() => _build();

  _$UpdateEnvelopeGroupRequest _build() {
    final _$result = _$v ??
        _$UpdateEnvelopeGroupRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'UpdateEnvelopeGroupRequest', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
