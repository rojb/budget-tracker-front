// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_line.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnvelopeLine extends EnvelopeLine {
  @override
  final Envelope envelope;
  @override
  final int assignedMinor;
  @override
  final int availableMinor;

  factory _$EnvelopeLine([void Function(EnvelopeLineBuilder)? updates]) =>
      (EnvelopeLineBuilder()..update(updates))._build();

  _$EnvelopeLine._(
      {required this.envelope,
      required this.assignedMinor,
      required this.availableMinor})
      : super._();
  @override
  EnvelopeLine rebuild(void Function(EnvelopeLineBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeLineBuilder toBuilder() => EnvelopeLineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnvelopeLine &&
        envelope == other.envelope &&
        assignedMinor == other.assignedMinor &&
        availableMinor == other.availableMinor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, envelope.hashCode);
    _$hash = $jc(_$hash, assignedMinor.hashCode);
    _$hash = $jc(_$hash, availableMinor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnvelopeLine')
          ..add('envelope', envelope)
          ..add('assignedMinor', assignedMinor)
          ..add('availableMinor', availableMinor))
        .toString();
  }
}

class EnvelopeLineBuilder
    implements Builder<EnvelopeLine, EnvelopeLineBuilder> {
  _$EnvelopeLine? _$v;

  EnvelopeBuilder? _envelope;
  EnvelopeBuilder get envelope => _$this._envelope ??= EnvelopeBuilder();
  set envelope(EnvelopeBuilder? envelope) => _$this._envelope = envelope;

  int? _assignedMinor;
  int? get assignedMinor => _$this._assignedMinor;
  set assignedMinor(int? assignedMinor) =>
      _$this._assignedMinor = assignedMinor;

  int? _availableMinor;
  int? get availableMinor => _$this._availableMinor;
  set availableMinor(int? availableMinor) =>
      _$this._availableMinor = availableMinor;

  EnvelopeLineBuilder() {
    EnvelopeLine._defaults(this);
  }

  EnvelopeLineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _envelope = $v.envelope.toBuilder();
      _assignedMinor = $v.assignedMinor;
      _availableMinor = $v.availableMinor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnvelopeLine other) {
    _$v = other as _$EnvelopeLine;
  }

  @override
  void update(void Function(EnvelopeLineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnvelopeLine build() => _build();

  _$EnvelopeLine _build() {
    _$EnvelopeLine _$result;
    try {
      _$result = _$v ??
          _$EnvelopeLine._(
            envelope: envelope.build(),
            assignedMinor: BuiltValueNullFieldError.checkNotNull(
                assignedMinor, r'EnvelopeLine', 'assignedMinor'),
            availableMinor: BuiltValueNullFieldError.checkNotNull(
                availableMinor, r'EnvelopeLine', 'availableMinor'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'envelope';
        envelope.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'EnvelopeLine', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
