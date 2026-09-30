// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payee_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePayeeRequest extends CreatePayeeRequest {
  @override
  final String name;
  @override
  final String? suggestedEnvelopeId;

  factory _$CreatePayeeRequest(
          [void Function(CreatePayeeRequestBuilder)? updates]) =>
      (CreatePayeeRequestBuilder()..update(updates))._build();

  _$CreatePayeeRequest._({required this.name, this.suggestedEnvelopeId})
      : super._();
  @override
  CreatePayeeRequest rebuild(
          void Function(CreatePayeeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePayeeRequestBuilder toBuilder() =>
      CreatePayeeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePayeeRequest &&
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
    return (newBuiltValueToStringHelper(r'CreatePayeeRequest')
          ..add('name', name)
          ..add('suggestedEnvelopeId', suggestedEnvelopeId))
        .toString();
  }
}

class CreatePayeeRequestBuilder
    implements Builder<CreatePayeeRequest, CreatePayeeRequestBuilder> {
  _$CreatePayeeRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _suggestedEnvelopeId;
  String? get suggestedEnvelopeId => _$this._suggestedEnvelopeId;
  set suggestedEnvelopeId(String? suggestedEnvelopeId) =>
      _$this._suggestedEnvelopeId = suggestedEnvelopeId;

  CreatePayeeRequestBuilder() {
    CreatePayeeRequest._defaults(this);
  }

  CreatePayeeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _suggestedEnvelopeId = $v.suggestedEnvelopeId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePayeeRequest other) {
    _$v = other as _$CreatePayeeRequest;
  }

  @override
  void update(void Function(CreatePayeeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePayeeRequest build() => _build();

  _$CreatePayeeRequest _build() {
    final _$result = _$v ??
        _$CreatePayeeRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CreatePayeeRequest', 'name'),
          suggestedEnvelopeId: suggestedEnvelopeId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
