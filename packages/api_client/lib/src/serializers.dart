//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:api_client/src/date_serializer.dart';
import 'package:api_client/src/model/date.dart';

import 'package:api_client/src/model/account.dart';
import 'package:api_client/src/model/account_detail.dart';
import 'package:api_client/src/model/account_type.dart';
import 'package:api_client/src/model/auth_session.dart';
import 'package:api_client/src/model/create_account_request.dart';
import 'package:api_client/src/model/create_payee_request.dart';
import 'package:api_client/src/model/create_plan_request.dart';
import 'package:api_client/src/model/currency.dart';
import 'package:api_client/src/model/currency_code.dart';
import 'package:api_client/src/model/error.dart';
import 'package:api_client/src/model/error_message.dart';
import 'package:api_client/src/model/health_status.dart';
import 'package:api_client/src/model/login_request.dart';
import 'package:api_client/src/model/page_meta.dart';
import 'package:api_client/src/model/payee.dart';
import 'package:api_client/src/model/payee_page.dart';
import 'package:api_client/src/model/plan.dart';
import 'package:api_client/src/model/plan_member.dart';
import 'package:api_client/src/model/plan_role.dart';
import 'package:api_client/src/model/register_request.dart';
import 'package:api_client/src/model/update_account_request.dart';
import 'package:api_client/src/model/update_payee_request.dart';
import 'package:api_client/src/model/update_plan_request.dart';
import 'package:api_client/src/model/user.dart';
import 'package:api_client/src/model/validation_error.dart';

part 'serializers.g.dart';

@SerializersFor([
  Account,$Account,
  AccountDetail,
  AccountType,
  AuthSession,
  CreateAccountRequest,
  CreatePayeeRequest,
  CreatePlanRequest,
  Currency,
  CurrencyCode,
  Error,
  ErrorMessage,
  HealthStatus,
  LoginRequest,
  PageMeta,$PageMeta,
  Payee,
  PayeePage,
  Plan,
  PlanMember,
  PlanRole,
  RegisterRequest,
  UpdateAccountRequest,
  UpdatePayeeRequest,
  UpdatePlanRequest,
  User,
  ValidationError,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Plan)]),
        () => ListBuilder<Plan>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Payee)]),
        () => ListBuilder<Payee>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(PlanMember)]),
        () => ListBuilder<PlanMember>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Account)]),
        () => ListBuilder<Account>(),
      )
      ..add(Account.serializer)
      ..add(PageMeta.serializer)
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
