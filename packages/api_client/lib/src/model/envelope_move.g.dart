// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_move.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EnvelopeMoveDirectionEnum _$envelopeMoveDirectionEnum_in_ =
    const EnvelopeMoveDirectionEnum._('in_');
const EnvelopeMoveDirectionEnum _$envelopeMoveDirectionEnum_out_ =
    const EnvelopeMoveDirectionEnum._('out_');

EnvelopeMoveDirectionEnum _$envelopeMoveDirectionEnumValueOf(String name) {
  switch (name) {
    case 'in_':
      return _$envelopeMoveDirectionEnum_in_;
    case 'out_':
      return _$envelopeMoveDirectionEnum_out_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EnvelopeMoveDirectionEnum> _$envelopeMoveDirectionEnumValues =
    BuiltSet<EnvelopeMoveDirectionEnum>(const <EnvelopeMoveDirectionEnum>[
  _$envelopeMoveDirectionEnum_in_,
  _$envelopeMoveDirectionEnum_out_,
]);

Serializer<EnvelopeMoveDirectionEnum> _$envelopeMoveDirectionEnumSerializer =
    _$EnvelopeMoveDirectionEnumSerializer();

class _$EnvelopeMoveDirectionEnumSerializer
    implements PrimitiveSerializer<EnvelopeMoveDirectionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'in_': 'in',
    'out_': 'out',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'in': 'in_',
    'out': 'out_',
  };

  @override
  final Iterable<Type> types = const <Type>[EnvelopeMoveDirectionEnum];
  @override
  final String wireName = 'EnvelopeMoveDirectionEnum';

  @override
  Object serialize(Serializers serializers, EnvelopeMoveDirectionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EnvelopeMoveDirectionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EnvelopeMoveDirectionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$EnvelopeMove extends EnvelopeMove {
  @override
  final String id;
  @override
  final EnvelopeMoveDirectionEnum direction;
  @override
  final String? counterpartId;
  @override
  final String counterpartName;
  @override
  final int amountMinor;
  @override
  final String month;
  @override
  final DateTime createdAt;

  factory _$EnvelopeMove([void Function(EnvelopeMoveBuilder)? updates]) =>
      (EnvelopeMoveBuilder()..update(updates))._build();

  _$EnvelopeMove._(
      {required this.id,
      required this.direction,
      this.counterpartId,
      required this.counterpartName,
      required this.amountMinor,
      required this.month,
      required this.createdAt})
      : super._();
  @override
  EnvelopeMove rebuild(void Function(EnvelopeMoveBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EnvelopeMoveBuilder toBuilder() => EnvelopeMoveBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnvelopeMove &&
        id == other.id &&
        direction == other.direction &&
        counterpartId == other.counterpartId &&
        counterpartName == other.counterpartName &&
        amountMinor == other.amountMinor &&
        month == other.month &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, direction.hashCode);
    _$hash = $jc(_$hash, counterpartId.hashCode);
    _$hash = $jc(_$hash, counterpartName.hashCode);
    _$hash = $jc(_$hash, amountMinor.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnvelopeMove')
          ..add('id', id)
          ..add('direction', direction)
          ..add('counterpartId', counterpartId)
          ..add('counterpartName', counterpartName)
          ..add('amountMinor', amountMinor)
          ..add('month', month)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class EnvelopeMoveBuilder
    implements Builder<EnvelopeMove, EnvelopeMoveBuilder> {
  _$EnvelopeMove? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  EnvelopeMoveDirectionEnum? _direction;
  EnvelopeMoveDirectionEnum? get direction => _$this._direction;
  set direction(EnvelopeMoveDirectionEnum? direction) =>
      _$this._direction = direction;

  String? _counterpartId;
  String? get counterpartId => _$this._counterpartId;
  set counterpartId(String? counterpartId) =>
      _$this._counterpartId = counterpartId;

  String? _counterpartName;
  String? get counterpartName => _$this._counterpartName;
  set counterpartName(String? counterpartName) =>
      _$this._counterpartName = counterpartName;

  int? _amountMinor;
  int? get amountMinor => _$this._amountMinor;
  set amountMinor(int? amountMinor) => _$this._amountMinor = amountMinor;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  EnvelopeMoveBuilder() {
    EnvelopeMove._defaults(this);
  }

  EnvelopeMoveBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _direction = $v.direction;
      _counterpartId = $v.counterpartId;
      _counterpartName = $v.counterpartName;
      _amountMinor = $v.amountMinor;
      _month = $v.month;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnvelopeMove other) {
    _$v = other as _$EnvelopeMove;
  }

  @override
  void update(void Function(EnvelopeMoveBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnvelopeMove build() => _build();

  _$EnvelopeMove _build() {
    final _$result = _$v ??
        _$EnvelopeMove._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'EnvelopeMove', 'id'),
          direction: BuiltValueNullFieldError.checkNotNull(
              direction, r'EnvelopeMove', 'direction'),
          counterpartId: counterpartId,
          counterpartName: BuiltValueNullFieldError.checkNotNull(
              counterpartName, r'EnvelopeMove', 'counterpartName'),
          amountMinor: BuiltValueNullFieldError.checkNotNull(
              amountMinor, r'EnvelopeMove', 'amountMinor'),
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'EnvelopeMove', 'month'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'EnvelopeMove', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
