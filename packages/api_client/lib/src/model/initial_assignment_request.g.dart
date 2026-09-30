// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_assignment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InitialAssignmentRequest extends InitialAssignmentRequest {
  @override
  final String? month;
  @override
  final BuiltList<InitialAssignment> assignments;

  factory _$InitialAssignmentRequest(
          [void Function(InitialAssignmentRequestBuilder)? updates]) =>
      (InitialAssignmentRequestBuilder()..update(updates))._build();

  _$InitialAssignmentRequest._({this.month, required this.assignments})
      : super._();
  @override
  InitialAssignmentRequest rebuild(
          void Function(InitialAssignmentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InitialAssignmentRequestBuilder toBuilder() =>
      InitialAssignmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InitialAssignmentRequest &&
        month == other.month &&
        assignments == other.assignments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, assignments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InitialAssignmentRequest')
          ..add('month', month)
          ..add('assignments', assignments))
        .toString();
  }
}

class InitialAssignmentRequestBuilder
    implements
        Builder<InitialAssignmentRequest, InitialAssignmentRequestBuilder> {
  _$InitialAssignmentRequest? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  ListBuilder<InitialAssignment>? _assignments;
  ListBuilder<InitialAssignment> get assignments =>
      _$this._assignments ??= ListBuilder<InitialAssignment>();
  set assignments(ListBuilder<InitialAssignment>? assignments) =>
      _$this._assignments = assignments;

  InitialAssignmentRequestBuilder() {
    InitialAssignmentRequest._defaults(this);
  }

  InitialAssignmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _assignments = $v.assignments.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InitialAssignmentRequest other) {
    _$v = other as _$InitialAssignmentRequest;
  }

  @override
  void update(void Function(InitialAssignmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InitialAssignmentRequest build() => _build();

  _$InitialAssignmentRequest _build() {
    _$InitialAssignmentRequest _$result;
    try {
      _$result = _$v ??
          _$InitialAssignmentRequest._(
            month: month,
            assignments: assignments.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'assignments';
        assignments.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'InitialAssignmentRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
