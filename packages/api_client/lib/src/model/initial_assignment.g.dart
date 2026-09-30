// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_assignment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InitialAssignment extends InitialAssignment {
  @override
  final String envelopeId;
  @override
  final int amountMinor;

  factory _$InitialAssignment(
          [void Function(InitialAssignmentBuilder)? updates]) =>
      (InitialAssignmentBuilder()..update(updates))._build();

  _$InitialAssignment._({required this.envelopeId, required this.amountMinor})
      : super._();
  @override
  InitialAssignment rebuild(void Function(InitialAssignmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InitialAssignmentBuilder toBuilder() =>
      InitialAssignmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InitialAssignment &&
        envelopeId == other.envelopeId &&
        amountMinor == other.amountMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, envelopeId.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InitialAssignment')
          ..add('envelopeId', envelopeId)
          ..add('amountMinor', amountMinor))
        .toString();
  }
}

class InitialAssignmentBuilder
    implements Builder<InitialAssignment, InitialAssignmentBuilder> {
  _$InitialAssignment? _$v;

  String? _envelopeId;
  String? get envelopeId => _$this._envelopeId;
  set envelopeId(String? envelopeId) => _$this._envelopeId = envelopeId;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  InitialAssignmentBuilder() {
    InitialAssignment._defaults(this);
  }

  InitialAssignmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _envelopeId = $v.envelopeId;
      _amountMinor = $v.amountMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InitialAssignment other) {
    _$v = other as _$InitialAssignment;
  }

  @override
  void update(void Function(InitialAssignmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InitialAssignment build() => _build();

  _$InitialAssignment _build() {
    final _$result = _$v ??
        _$InitialAssignment._(
          envelopeId: BuiltValueNullFieldError.checkNotNull(
              envelopeId, r'InitialAssignment', 'envelopeId'),
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'InitialAssignment', 'amountMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
