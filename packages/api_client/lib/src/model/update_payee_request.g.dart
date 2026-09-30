// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_payee_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePayeeRequest extends UpdatePayeeRequest {
  @override
  final String? name;
  @override
  final String? suggestedEnvelopeId;

  factory _$UpdatePayeeRequest(
          [void Function(UpdatePayeeRequestBuilder)? updates]) =>
      (UpdatePayeeRequestBuilder()..update(updates))._build();

  _$UpdatePayeeRequest._({this.name, this.suggestedEnvelopeId}) : super._();
  @override
  UpdatePayeeRequest rebuild(
          void Function(UpdatePayeeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePayeeRequestBuilder toBuilder() =>
      UpdatePayeeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePayeeRequest &&
        name == other.name &&
        suggestedEnvelopeId == other.suggestedEnvelopeId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, suggestedEnvelopeId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdatePayeeRequest')
          ..add('name', name)
          ..add('suggestedEnvelopeId', suggestedEnvelopeId))
        .toString();
  }
}

class UpdatePayeeRequestBuilder
    implements Builder<UpdatePayeeRequest, UpdatePayeeRequestBuilder> {
  _$UpdatePayeeRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _suggestedEnvelopeId;
  String? get suggestedEnvelopeId => _$this._suggestedEnvelopeId;
  set suggestedEnvelopeId(String? suggestedEnvelopeId) =>
      _$this._suggestedEnvelopeId = suggestedEnvelopeId;

  UpdatePayeeRequestBuilder() {
    UpdatePayeeRequest._defaults(this);
  }

  UpdatePayeeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _suggestedEnvelopeId = $v.suggestedEnvelopeId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePayeeRequest other) {
    _$v = other as _$UpdatePayeeRequest;
  }

  @override
  void update(void Function(UpdatePayeeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePayeeRequest build() => _build();

  _$UpdatePayeeRequest _build() {
    final _$result = _$v ??
        _$UpdatePayeeRequest._(
          name: name,
          suggestedEnvelopeId: suggestedEnvelopeId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
