//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/create_account_request.dart';
import 'package:api_client/src/model/currency_code.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_plan_request.g.dart';

/// CreatePlanRequest
///
/// Properties:
/// * [name] 
/// * [currencyCode] 
/// * [timeZone] - IANA time zone; defaults to America/Argentina/Buenos_Aires.
/// * [firstAccount] 
@BuiltValue()
abstract class CreatePlanRequest implements Built<CreatePlanRequest, CreatePlanRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'currencyCode')
  CurrencyCode get currencyCode;
  // enum currencyCodeEnum {  ARS,  USD,  EUR,  };

  /// IANA time zone; defaults to America/Argentina/Buenos_Aires.
  @BuiltValueField(wireName: r'timeZone')
  String? get timeZone;

  @BuiltValueField(wireName: r'firstAccount')
  CreateAccountRequest? get firstAccount;

  CreatePlanRequest._();

  factory CreatePlanRequest([void updates(CreatePlanRequestBuilder b)]) = _$CreatePlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePlanRequest> get serializer => _$CreatePlanRequestSerializer();
}

class _$CreatePlanRequestSerializer implements PrimitiveSerializer<CreatePlanRequest> {
  @override
  final Iterable<Type> types = const [CreatePlanRequest, _$CreatePlanRequest];

  @override
  final String wireName = r'CreatePlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'currencyCode';
    yield serializers.serialize(
      object.currencyCode,
      specifiedType: const FullType(CurrencyCode),
    );
    if (object.timeZone != null) {
      yield r'timeZone';
      yield serializers.serialize(
        object.timeZone,
        specifiedType: const FullType(String),
      );
    }
    if (object.firstAccount != null) {
      yield r'firstAccount';
      yield serializers.serialize(
        object.firstAccount,
        specifiedType: const FullType(CreateAccountRequest),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePlanRequestBuilder result,
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
        case r'currencyCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CurrencyCode),
          ) as CurrencyCode;
          result.currencyCode = valueDes;
          break;
        case r'timeZone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.timeZone = valueDes;
          break;
        case r'firstAccount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CreateAccountRequest),
          ) as CreateAccountRequest?;
          if (valueDes == null) continue;
          result.firstAccount.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatePlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePlanRequestBuilder();
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


