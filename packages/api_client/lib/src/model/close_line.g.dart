// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_line.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CloseLine extends CloseLine {
  @override
  final String envelopeId;
  @override
  final String name;
  @override
  final int amountMinor;

  factory _$CloseLine([void Function(CloseLineBuilder)? updates]) =>
      (CloseLineBuilder()..update(updates))._build();

  _$CloseLine._(
      {required this.envelopeId, required this.name, required this.amountMinor})
      : super._();
  @override
  CloseLine rebuild(void Function(CloseLineBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CloseLineBuilder toBuilder() => CloseLineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CloseLine &&
        envelopeId == other.envelopeId &&
        name == other.name &&
        amountMinor == other.amountMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, envelopeId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CloseLine')
          ..add('envelopeId', envelopeId)
          ..add('name', name)
          ..add('amountMinor', amountMinor))
        .toString();
  }
}

class CloseLineBuilder implements Builder<CloseLine, CloseLineBuilder> {
  _$CloseLine? _$v;

  String? _envelopeId;
  String? get envelopeId => _$this._envelopeId;
  set envelopeId(String? envelopeId) => _$this._envelopeId = envelopeId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  CloseLineBuilder() {
    CloseLine._defaults(this);
  }

  CloseLineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _envelopeId = $v.envelopeId;
      _name = $v.name;
      _amountMinor = $v.amountMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CloseLine other) {
    _$v = other as _$CloseLine;
  }

  @override
  void update(void Function(CloseLineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CloseLine build() => _build();

  _$CloseLine _build() {
    final _$result = _$v ??
        _$CloseLine._(
          envelopeId: BuiltValueNullFieldError.checkNotNull(
              envelopeId, r'CloseLine', 'envelopeId'),
          name:
              BuiltValueNullFieldError.checkNotNull(name, r'CloseLine', 'name'),
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'CloseLine', 'amountMinor'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
