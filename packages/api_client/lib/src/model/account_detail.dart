//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/account.dart';
import 'package:api_client/src/model/account_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_detail.g.dart';

/// An account plus the money that entered and left it in one month.
///
/// Properties:
/// * [id] - UUID v4 identifier.
/// * [name] 
/// * [type] 
/// * [openingBalanceMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [balanceMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [archived] 
/// * [archivedAt] - When the account was archived; present only while `archived` is true.
/// * [createdAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
/// * [month] - Budget month as YYYY-MM.
/// * [inflowMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
/// * [outflowMinor] - Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
@BuiltValue()
abstract class AccountDetail implements Account, Built<AccountDetail, AccountDetailBuilder> {
  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'outflowMinor')
  int get outflowMinor;

  /// Integer amount in the minor units of the owning plan's currency, as defined by that currency's `minorUnits` (ARS amounts are whole pesos; USD and EUR are cents). Never a float. Use in fields named `<thing>Minor`. 
  @BuiltValueField(wireName: r'inflowMinor')
  int get inflowMinor;

  /// Budget month as YYYY-MM.
  @BuiltValueField(wireName: r'month')
  String get month;

  AccountDetail._();

  factory AccountDetail([void updates(AccountDetailBuilder b)]) = _$AccountDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountDetail> get serializer => _$AccountDetailSerializer();
}

class _$AccountDetailSerializer implements PrimitiveSerializer<AccountDetail> {
  @override
  final Iterable<Type> types = const [AccountDetail, _$AccountDetail];

  @override
  final String wireName = r'AccountDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'outflowMinor';
    yield serializers.serialize(
      object.outflowMinor,
      specifiedType: const FullType(int),
    );
    yield r'archived';
    yield serializers.serialize(
      object.archived,
      specifiedType: const FullType(bool),
    );
    if (object.archivedAt != null) {
      yield r'archivedAt';
      yield serializers.serialize(
        object.archivedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'inflowMinor';
    yield serializers.serialize(
      object.inflowMinor,
      specifiedType: const FullType(int),
    );
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'openingBalanceMinor';
    yield serializers.serialize(
      object.openingBalanceMinor,
      specifiedType: const FullType(int),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(AccountType),
    );
    yield r'balanceMinor';
    yield serializers.serialize(
      object.balanceMinor,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountDetailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'outflowMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.outflowMinor = valueDes;
          break;
        case r'archived':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.archived = valueDes;
          break;
        case r'archivedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.archivedAt = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'inflowMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.inflowMinor = valueDes;
          break;
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.month = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'openingBalanceMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.openingBalanceMinor = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountType),
          ) as AccountType;
          result.type = valueDes;
          break;
        case r'balanceMinor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.balanceMinor = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountDetailBuilder();
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


