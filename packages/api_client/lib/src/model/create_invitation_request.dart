//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/invitation_role.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_invitation_request.g.dart';

/// CreateInvitationRequest
///
/// Properties:
/// * [role] 
@BuiltValue()
abstract class CreateInvitationRequest implements Built<CreateInvitationRequest, CreateInvitationRequestBuilder> {
  @BuiltValueField(wireName: r'role')
  InvitationRole get role;
  // enum roleEnum {  editor,  viewer,  };

  CreateInvitationRequest._();

  factory CreateInvitationRequest([void updates(CreateInvitationRequestBuilder b)]) = _$CreateInvitationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateInvitationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateInvitationRequest> get serializer => _$CreateInvitationRequestSerializer();
}

class _$CreateInvitationRequestSerializer implements PrimitiveSerializer<CreateInvitationRequest> {
  @override
  final Iterable<Type> types = const [CreateInvitationRequest, _$CreateInvitationRequest];

  @override
  final String wireName = r'CreateInvitationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateInvitationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(InvitationRole),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateInvitationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateInvitationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InvitationRole),
          ) as InvitationRole;
          result.role = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateInvitationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateInvitationRequestBuilder();
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


