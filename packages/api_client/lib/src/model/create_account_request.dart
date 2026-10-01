//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/account_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_account_request.g.dart';

/// CreateAccountRequest
///
/// Properties:
/// * [name] 
/// * [type] 
/// * [openingBalanceMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD, EUR and BOB are cents). Never a float. Use in fields named `<thing>Minor`. 
@BuiltValue()
abstract class CreateAccountRequest implements Built<CreateAccountRequest, CreateAccountRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'type')
  AccountType get type;
  // enum typeEnum {  bank,  digitalWallet,  cash,  };

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD, EUR and BOB are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'openingBalanceMinor')
  int get openingBalanceMinor;

  CreateAccountRequest._();

  factory CreateAccountRequest([void updates(CreateAccountRequestBuilder b)]) = _$CreateAccountRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAccountRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAccountRequest> get serializer => _$CreateAccountRequestSerializer();
}

class _$CreateAccountRequestSerializer implements PrimitiveSerializer<CreateAccountRequest> {
  @override
  final Iterable<Type> types = const [CreateAccountRequest, _$CreateAccountRequest];

  @override
  final String wireName = r'CreateAccountRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(AccountType),
    );
    yield r'openingBalanceMinor';
    yield serializers.serialize(
      object.openingBalanceMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateAccountRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountType),
          ) as AccountType;
          result.type = valueDes;
          break;
        case r'openingBalanceMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.openingBalanceMinor = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateAccountRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAccountRequestBuilder();
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


