// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope_icon.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EnvelopeIcon _$tag = const EnvelopeIcon._('tag');
const EnvelopeIcon _$home = const EnvelopeIcon._('home');
const EnvelopeIcon _$bus = const EnvelopeIcon._('bus');
const EnvelopeIcon _$utensils = const EnvelopeIcon._('utensils');
const EnvelopeIcon _$heartPulse = const EnvelopeIcon._('heartPulse');
const EnvelopeIcon _$gift = const EnvelopeIcon._('gift');
const EnvelopeIcon _$cart = const EnvelopeIcon._('cart');
const EnvelopeIcon _$pill = const EnvelopeIcon._('pill');
const EnvelopeIcon _$wifi = const EnvelopeIcon._('wifi');
const EnvelopeIcon _$settings = const EnvelopeIcon._('settings');
const EnvelopeIcon _$ticket = const EnvelopeIcon._('ticket');
const EnvelopeIcon _$repeat = const EnvelopeIcon._('repeat');
const EnvelopeIcon _$lifeBuoy = const EnvelopeIcon._('lifeBuoy');
const EnvelopeIcon _$plane = const EnvelopeIcon._('plane');

EnvelopeIcon _$valueOf(String name) {
  switch (name) {
    case 'tag':
      return _$tag;
    case 'home':
      return _$home;
    case 'bus':
      return _$bus;
    case 'utensils':
      return _$utensils;
    case 'heartPulse':
      return _$heartPulse;
    case 'gift':
      return _$gift;
    case 'cart':
      return _$cart;
    case 'pill':
      return _$pill;
    case 'wifi':
      return _$wifi;
    case 'settings':
      return _$settings;
    case 'ticket':
      return _$ticket;
    case 'repeat':
      return _$repeat;
    case 'lifeBuoy':
      return _$lifeBuoy;
    case 'plane':
      return _$plane;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EnvelopeIcon> _$values =
    BuiltSet<EnvelopeIcon>(const <EnvelopeIcon>[
  _$tag,
  _$home,
  _$bus,
  _$utensils,
  _$heartPulse,
  _$gift,
  _$cart,
  _$pill,
  _$wifi,
  _$settings,
  _$ticket,
  _$repeat,
  _$lifeBuoy,
  _$plane,
]);

class _$EnvelopeIconMeta {
  const _$EnvelopeIconMeta();
  EnvelopeIcon get tag => _$tag;
  EnvelopeIcon get home => _$home;
  EnvelopeIcon get bus => _$bus;
  EnvelopeIcon get utensils => _$utensils;
  EnvelopeIcon get heartPulse => _$heartPulse;
  EnvelopeIcon get gift => _$gift;
  EnvelopeIcon get cart => _$cart;
  EnvelopeIcon get pill => _$pill;
  EnvelopeIcon get wifi => _$wifi;
  EnvelopeIcon get settings => _$settings;
  EnvelopeIcon get ticket => _$ticket;
  EnvelopeIcon get repeat => _$repeat;
  EnvelopeIcon get lifeBuoy => _$lifeBuoy;
  EnvelopeIcon get plane => _$plane;
  EnvelopeIcon valueOf(String name) => _$valueOf(name);
  BuiltSet<EnvelopeIcon> get values => _$values;
}

mixin _$EnvelopeIconMixin {
  // ignore: non_constant_identifier_names
  _$EnvelopeIconMeta get EnvelopeIcon => const _$EnvelopeIconMeta();
}

Serializer<EnvelopeIcon> _$envelopeIconSerializer = _$EnvelopeIconSerializer();

class _$EnvelopeIconSerializer implements PrimitiveSerializer<EnvelopeIcon> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'tag': 'tag',
    'home': 'home',
    'bus': 'bus',
    'utensils': 'utensils',
    'heartPulse': 'heartPulse',
    'gift': 'gift',
    'cart': 'cart',
    'pill': 'pill',
    'wifi': 'wifi',
    'settings': 'settings',
    'ticket': 'ticket',
    'repeat': 'repeat',
    'lifeBuoy': 'lifeBuoy',
    'plane': 'plane',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'tag': 'tag',
    'home': 'home',
    'bus': 'bus',
    'utensils': 'utensils',
    'heartPulse': 'heartPulse',
    'gift': 'gift',
    'cart': 'cart',
    'pill': 'pill',
    'wifi': 'wifi',
    'settings': 'settings',
    'ticket': 'ticket',
    'repeat': 'repeat',
    'lifeBuoy': 'lifeBuoy',
    'plane': 'plane',
  };

  @override
  final Iterable<Type> types = const <Type>[EnvelopeIcon];
  @override
  final String wireName = 'EnvelopeIcon';

  @override
  Object serialize(Serializers serializers, EnvelopeIcon object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EnvelopeIcon deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EnvelopeIcon.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
