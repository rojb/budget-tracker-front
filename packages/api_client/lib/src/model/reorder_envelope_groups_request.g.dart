// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_envelope_groups_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReorderEnvelopeGroupsRequest extends ReorderEnvelopeGroupsRequest {
  @override
  final BuiltList<String> groupIds;

  factory _$ReorderEnvelopeGroupsRequest(
          [void Function(ReorderEnvelopeGroupsRequestBuilder)? updates]) =>
      (ReorderEnvelopeGroupsRequestBuilder()..update(updates))._build();

  _$ReorderEnvelopeGroupsRequest._({required this.groupIds}) : super._();
  @override
  ReorderEnvelopeGroupsRequest rebuild(
          void Function(ReorderEnvelopeGroupsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReorderEnvelopeGroupsRequestBuilder toBuilder() =>
      ReorderEnvelopeGroupsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReorderEnvelopeGroupsRequest && groupIds == other.groupIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, groupIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReorderEnvelopeGroupsRequest')
          ..add('groupIds', groupIds))
        .toString();
  }
}

class ReorderEnvelopeGroupsRequestBuilder
    implements
        Builder<ReorderEnvelopeGroupsRequest,
            ReorderEnvelopeGroupsRequestBuilder> {
  _$ReorderEnvelopeGroupsRequest? _$v;

  ListBuilder<String>? _groupIds;
  ListBuilder<String> get groupIds =>
      _$this._groupIds ??= ListBuilder<String>();
  set groupIds(ListBuilder<String>? groupIds) => _$this._groupIds = groupIds;

  ReorderEnvelopeGroupsRequestBuilder() {
    ReorderEnvelopeGroupsRequest._defaults(this);
  }

  ReorderEnvelopeGroupsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _groupIds = $v.groupIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReorderEnvelopeGroupsRequest other) {
    _$v = other as _$ReorderEnvelopeGroupsRequest;
  }

  @override
  void update(void Function(ReorderEnvelopeGroupsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReorderEnvelopeGroupsRequest build() => _build();

  _$ReorderEnvelopeGroupsRequest _build() {
    _$ReorderEnvelopeGroupsRequest _$result;
    try {
      _$result = _$v ??
          _$ReorderEnvelopeGroupsRequest._(
            groupIds: groupIds.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'groupIds';
        groupIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ReorderEnvelopeGroupsRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
