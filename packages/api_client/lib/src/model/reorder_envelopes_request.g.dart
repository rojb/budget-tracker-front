// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_envelopes_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReorderEnvelopesRequest extends ReorderEnvelopesRequest {
  @override
  final String? groupId;
  @override
  final BuiltList<String> envelopeIds;

  factory _$ReorderEnvelopesRequest(
          [void Function(ReorderEnvelopesRequestBuilder)? updates]) =>
      (ReorderEnvelopesRequestBuilder()..update(updates))._build();

  _$ReorderEnvelopesRequest._({this.groupId, required this.envelopeIds})
      : super._();
  @override
  ReorderEnvelopesRequest rebuild(
          void Function(ReorderEnvelopesRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReorderEnvelopesRequestBuilder toBuilder() =>
      ReorderEnvelopesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReorderEnvelopesRequest &&
        groupId == other.groupId &&
        envelopeIds == other.envelopeIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, envelopeIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReorderEnvelopesRequest')
          ..add('groupId', groupId)
          ..add('envelopeIds', envelopeIds))
        .toString();
  }
}

class ReorderEnvelopesRequestBuilder
    implements
        Builder<ReorderEnvelopesRequest, ReorderEnvelopesRequestBuilder> {
  _$ReorderEnvelopesRequest? _$v;

  String? _groupId;
  String? get groupId => _$this._groupId;
  set groupId(String? groupId) => _$this._groupId = groupId;

  ListBuilder<String>? _envelopeIds;
  ListBuilder<String> get envelopeIds =>
      _$this._envelopeIds ??= ListBuilder<String>();
  set envelopeIds(ListBuilder<String>? envelopeIds) =>
      _$this._envelopeIds = envelopeIds;

  ReorderEnvelopesRequestBuilder() {
    ReorderEnvelopesRequest._defaults(this);
  }

  ReorderEnvelopesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _groupId = $v.groupId;
      _envelopeIds = $v.envelopeIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReorderEnvelopesRequest other) {
    _$v = other as _$ReorderEnvelopesRequest;
  }

  @override
  void update(void Function(ReorderEnvelopesRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReorderEnvelopesRequest build() => _build();

  _$ReorderEnvelopesRequest _build() {
    _$ReorderEnvelopesRequest _$result;
    try {
      _$result = _$v ??
          _$ReorderEnvelopesRequest._(
            groupId: groupId,
            envelopeIds: envelopeIds.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'envelopeIds';
        envelopeIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ReorderEnvelopesRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
