//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/account_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_account_request.g.dart';

/// UpdateAccountRequest
///
/// Properties:
/// * [name] 
/// * [type] 
/// * [openingBalanceMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
@BuiltValue()
abstract class UpdateAccountRequest implements Built<UpdateAccountRequest, UpdateAccountRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'type')
  AccountType? get type;
  // enum typeEnum {  bank,  digitalWallet,  cash,  };

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'openingBalanceMinor')
  int? get openingBalanceMinor;

  UpdateAccountRequest._();

  factory UpdateAccountRequest([void updates(UpdateAccountRequestBuilder b)]) = _$UpdateAccountRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAccountRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAccountRequest> get serializer => _$UpdateAccountRequestSerializer();
}

class _$UpdateAccountRequestSerializer implements PrimitiveSerializer<UpdateAccountRequest> {
  @override
  final Iterable<Type> types = const [UpdateAccountRequest, _$UpdateAccountRequest];

  @override
  final String wireName = r'UpdateAccountRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(AccountType),
      );
    }
    if (object.openingBalanceMinor != null) {
      yield r'openingBalanceMinor';
      yield serializers.serialize(
        object.openingBalanceMinor,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAccountRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountType),
          ) as AccountType?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'openingBalanceMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
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
  UpdateAccountRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAccountRequestBuilder();
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


