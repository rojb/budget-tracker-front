import 'package:api_client/api_client.dart' as api;
import 'package:ui/ui.dart';

import '../../core/api/api_failure.dart';
import '../../core/api/api_gateway.dart';

enum PlanRole { owner, editor, viewer }

class PlanMemberData {
  const PlanMemberData({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
  });

  final String userId;
  final String name;
  final String email;
  final PlanRole role;

  /// Two-letter initials for avatars ("Sofía Martínez" -> "SO").
  String get initials {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed.substring(0, trimmed.length < 2 ? 1 : 2).toUpperCase();
  }
}

class PlanData {
  const PlanData({
    required this.id,
    required this.name,
    required this.currency,
    required this.timeZone,
    required this.myRole,
    required this.members,
  });

  final String id;
  final String name;
  final Currency currency;
  final String timeZone;
  final PlanRole myRole;
  final List<PlanMemberData> members;

  bool get canEdit => myRole != PlanRole.viewer;
}

/// First account of a new plan (screen 20).
class NewAccountData {
  const NewAccountData({
    required this.name,
    required this.type,
    required this.openingBalanceMinor,
  });

  final String name;
  final api.AccountType type;
  final int openingBalanceMinor;
}

/// Wraps the generated `PlansApi`; every error surfaces as [ApiFailure].
class PlansRepository {
  PlansRepository(this._gateway);

  final ApiGateway _gateway;

  api.PlansApi get _plans => _gateway.client.getPlansApi();

  Future<List<PlanData>> list() => guardApi(() async {
    final response = await _plans.listPlans();
    return (response.data ?? const <api.Plan>[]).map(toData).toList();
  });

  Future<PlanData> create({
    required String name,
    required Currency currency,
    NewAccountData? firstAccount,
  }) => guardApi(() async {
    final response = await _plans.createPlan(
      createPlanRequest: api.CreatePlanRequest((b) {
        b
          ..name = name
          ..currencyCode = api.CurrencyCode.valueOf(currency.code);
        if (firstAccount != null) {
          b.firstAccount
            ..name = firstAccount.name
            ..type = firstAccount.type
            ..openingBalanceMinor = firstAccount.openingBalanceMinor;
        }
      }),
    );
    return toData(response.data!);
  });

  static PlanData toData(api.Plan plan) => PlanData(
    id: plan.id,
    name: plan.name,
    currency: currencyOf(plan.currency.code),
    timeZone: plan.timeZone,
    myRole: _role(plan.myRole),
    members: [
      for (final member in plan.members)
        PlanMemberData(
          userId: member.userId,
          name: member.name,
          email: member.email,
          role: _role(member.role),
        ),
    ],
  );

  static PlanRole _role(api.PlanRole role) => switch (role) {
    api.PlanRole.owner => PlanRole.owner,
    api.PlanRole.editor => PlanRole.editor,
    _ => PlanRole.viewer,
  };
}

/// `packages/ui` currency for a contract currency code.
Currency currencyOf(api.CurrencyCode code) => switch (code) {
  api.CurrencyCode.USD => Currency.usd,
  api.CurrencyCode.EUR => Currency.eur,
  api.CurrencyCode.BOB => Currency.bob,
  _ => Currency.ars,
};
