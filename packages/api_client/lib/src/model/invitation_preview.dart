//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/currency.dart';
import 'package:api_client/src/model/invitation_role.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'invitation_preview.g.dart';

/// What a code gives access to. Never carries amounts or member emails.
///
/// Properties:
/// * [planName] 
/// * [ownerName] 
/// * [currency] 
/// * [role] 
/// * [expiresAt] - ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
@BuiltValue()
abstract class InvitationPreview implements Built<InvitationPreview, InvitationPreviewBuilder> {
  @BuiltValueField(wireName: r'planName')
  String get planName;

  @BuiltValueField(wireName: r'ownerName')
  String get ownerName;

  @BuiltValueField(wireName: r'currency')
  Currency get currency;

  @BuiltValueField(wireName: r'role')
  InvitationRole get role;
  // enum roleEnum {  editor,  viewer,  };

  /// ISO-8601 instant with UTC offset, e.g. 2026-09-29T14:30:00Z.
  @BuiltValueField(wireName: r'expiresAt')
  DateTime get expiresAt;

  InvitationPreview._();

  factory InvitationPreview([void updates(InvitationPreviewBuilder b)]) = _$InvitationPreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvitationPreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InvitationPreview> get serializer => _$InvitationPreviewSerializer();
}

class _$InvitationPreviewSerializer implements PrimitiveSerializer<InvitationPreview> {
  @override
  final Iterable<Type> types = const [InvitationPreview, _$InvitationPreview];

  @override
  final String wireName = r'InvitationPreview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InvitationPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'planName';
    yield serializers.serialize(
      object.planName,
      specifiedType: const FullType(String),
    );
    yield r'ownerName';
    yield serializers.serialize(
      object.ownerName,
      specifiedType: const FullType(String),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(Currency),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(InvitationRole),
    );
    yield r'expiresAt';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InvitationPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InvitationPreviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'planName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.planName = valueDes;
          break;
        case r'ownerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ownerName = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Currency),
          ) as Currency;
          result.currency.replace(valueDes);
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InvitationRole),
          ) as InvitationRole;
          result.role = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InvitationPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvitationPreviewBuilder();
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


