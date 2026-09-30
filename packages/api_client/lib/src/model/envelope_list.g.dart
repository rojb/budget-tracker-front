// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EnvelopeList extends EnvelopeList {
  @override
  final String month;
  @override
  final int readyToAssignMinor;
  @override
  final BuiltList<EnvelopeLine> items;

  factory _$EnvelopeList([void Function(EnvelopeListBuilder)? updates]) =>
      (EnvelopeListBuilder()..update(updates))._build();

  _$EnvelopeList._(
      {required this.month,
      required this.readyToAssignMinor,
      required this.items})
      : super._();
  @override
  EnvelopeList rebuild(void Function(EnvelopeListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeListBuilder toBuilder() => EnvelopeListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnvelopeList &&
        month == other.month &&
        readyToAssignMinor == other.readyToAssignMinor &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, readyToAssignMinor.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnvelopeList')
          ..add('month', month)
          ..add('readyToAssignMinor', readyToAssignMinor)
          ..add('items', items))
        .toString();
  }
}

class EnvelopeListBuilder
    implements Builder<EnvelopeList, EnvelopeListBuilder> {
  _$EnvelopeList? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  int? _readyToAssignMinor;
  int? get readyToAssignMinor => _$this._readyToAssignMinor;
  set readyToAssignMinor(int? readyToAssignMinor) =>
      _$this._readyToAssignMinor = readyToAssignMinor;

  ListBuilder<EnvelopeLine>? _items;
  ListBuilder<EnvelopeLine> get items =>
      _$this._items ??= ListBuilder<EnvelopeLine>();
  set items(ListBuilder<EnvelopeLine>? items) => _$this._items = items;

  EnvelopeListBuilder() {
    EnvelopeList._defaults(this);
  }

  EnvelopeListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _readyToAssignMinor = $v.readyToAssignMinor;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnvelopeList other) {
    _$v = other as _$EnvelopeList;
  }

  @override
  void update(void Function(EnvelopeListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnvelopeList build() => _build();

  _$EnvelopeList _build() {
    _$EnvelopeList _$result;
    try {
      _$result = _$v ??
          _$EnvelopeList._(
            month: BuiltValueNullFieldError.checkNotNull(
                month, r'EnvelopeList', 'month'),
            readyToAssignMinor: BuiltValueNullFieldError.checkNotNull(
                readyToAssignMinor, r'EnvelopeList', 'readyToAssignMinor'),
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'EnvelopeList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
