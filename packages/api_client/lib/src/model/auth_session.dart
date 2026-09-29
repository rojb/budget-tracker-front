//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_session.g.dart';

/// A signed JWT access token (default expiry 7 days, no refresh token) and its user.
///
/// Properties:
/// * [accessToken] - Sent as `Authorization: Bearer <accessToken>`.
/// * [user] 
@BuiltValue()
abstract class AuthSession implements Built<AuthSession, AuthSessionBuilder> {
  /// Sent as `Authorization: Bearer <accessToken>`.
  @BuiltValueField(wireName: r'accessToken')
  String get accessToken;

  @BuiltValueField(wireName: r'user')
  User get user;

  AuthSession._();

  factory AuthSession([void updates(AuthSessionBuilder b)]) = _$AuthSession;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthSessionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthSession> get serializer => _$AuthSessionSerializer();
}

class _$AuthSessionSerializer implements PrimitiveSerializer<AuthSession> {
  @override
  final Iterable<Type> types = const [AuthSession, _$AuthSession];

  @override
  final String wireName = r'AuthSession';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthSession object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'accessToken';
    yield serializers.serialize(
      object.accessToken,
      specifiedType: const FullType(String),
    );
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(User),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthSession object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthSessionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accessToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(User),
          ) as User;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthSession deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthSessionBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}


