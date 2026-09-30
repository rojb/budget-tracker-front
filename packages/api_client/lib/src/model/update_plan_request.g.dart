// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePlanRequest extends UpdatePlanRequest {
  @override
  final String name;

  factory _$UpdatePlanRequest(
          [void Function(UpdatePlanRequestBuilder)? updates]) =>
      (UpdatePlanRequestBuilder()..update(updates))._build();

  _$UpdatePlanRequest._({required this.name}) : super._();
  @override
  UpdatePlanRequest rebuild(void Function(UpdatePlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePlanRequestBuilder toBuilder() =>
      UpdatePlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePlanRequest && name == other.name;
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
    return (newBuiltValueToStringHelper(r'UpdatePlanRequest')
          ..add('name', name))
        .toString();
  }
}

class UpdatePlanRequestBuilder
    implements Builder<UpdatePlanRequest, UpdatePlanRequestBuilder> {
  _$UpdatePlanRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  UpdatePlanRequestBuilder() {
    UpdatePlanRequest._defaults(this);
  }

  UpdatePlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePlanRequest other) {
    _$v = other as _$UpdatePlanRequest;
  }

  @override
  void update(void Function(UpdatePlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePlanRequest build() => _build();

  _$UpdatePlanRequest _build() {
    final _$result = _$v ??
        _$UpdatePlanRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'UpdatePlanRequest', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
