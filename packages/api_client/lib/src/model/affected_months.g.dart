// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affected_months.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract mixin class AffectedMonthsBuilder {
  void replace(AffectedMonths other);
  void update(void Function(AffectedMonthsBuilder) updates);
  ListBuilder<String> get affectedMonths;
  set affectedMonths(ListBuilder<String>? affectedMonths);
}

class _$$AffectedMonths extends $AffectedMonths {
  @override
  final BuiltList<String> affectedMonths;

  factory _$$AffectedMonths([void Function($AffectedMonthsBuilder)? updates]) =>
      ($AffectedMonthsBuilder()..update(updates))._build();

  _$$AffectedMonths._({required this.affectedMonths}) : super._();
  @override
  $AffectedMonths rebuild(void Function($AffectedMonthsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $AffectedMonthsBuilder toBuilder() => $AffectedMonthsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $AffectedMonths && affectedMonths == other.affectedMonths;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, affectedMonths.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$AffectedMonths')
          ..add('affectedMonths', affectedMonths))
        .toString();
  }
}

class $AffectedMonthsBuilder
    implements
        Builder<$AffectedMonths, $AffectedMonthsBuilder>,
        AffectedMonthsBuilder {
  _$$AffectedMonths? _$v;

  ListBuilder<String>? _affectedMonths;
  ListBuilder<String> get affectedMonths =>
      _$this._affectedMonths ??= ListBuilder<String>();
  set affectedMonths(covariant ListBuilder<String>? affectedMonths) =>
      _$this._affectedMonths = affectedMonths;

  $AffectedMonthsBuilder() {
    $AffectedMonths._defaults(this);
  }

  $AffectedMonthsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _affectedMonths = $v.affectedMonths.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $AffectedMonths other) {
    _$v = other as _$$AffectedMonths;
  }

  @override
  void update(void Function($AffectedMonthsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $AffectedMonths build() => _build();

  _$$AffectedMonths _build() {
    _$$AffectedMonths _$result;
    try {
      _$result = _$v ??
          _$$AffectedMonths._(
            affectedMonths: affectedMonths.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'affectedMonths';
        affectedMonths.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'$AffectedMonths', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
