import '../core/api/api_gateway.dart';
import '../core/config.dart';
import '../core/plan/active_plan_storage.dart';
import '../core/session/session_storage.dart';
import '../features/accounts/accounts_controller.dart';
import '../features/accounts/accounts_repository.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/auth_repository.dart';
import '../features/auth/login_controller.dart';
import '../features/auth/register_controller.dart';
import '../features/home/home_controller.dart';
import '../features/plans/new_plan_controller.dart';
import '../features/sharing/join_controller.dart';
import '../features/sharing/pending_invite.dart';
import '../features/sharing/sharing_repository.dart';
import '../features/plans/plans_controller.dart';
import '../features/plans/plans_repository.dart';

/// Composition root: builds the object graph once and hands dependencies to
/// widgets through constructors.
class Dependencies {
  const Dependencies({
    required this.config,
    required this.apiGateway,
    required this.sessionStorage,
    required this.authRepository,
    required this.authController,
    required this.plansController,
    required this.accountsController,
    required this.sharingRepository,
    required this.pendingInvite,
  });

  factory Dependencies.create() {
    const config = AppConfig.fromEnvironment();
    final gateway = ApiGateway(baseUrl: config.apiBaseUrl);
    const storage = SecureSessionStorage();
    final repository = AuthRepository(gateway);
    final auth = AuthController(repository, storage, gateway);
    final plans = PlansController(
      PlansRepository(gateway),
      const SecureActivePlanStorage(),
      auth,
    );
    return Dependencies(
      config: config,
      apiGateway: gateway,
      sessionStorage: storage,
      authRepository: repository,
      authController: auth,
      plansController: plans,
      accountsController: AccountsController(
        AccountsRepository(gateway),
        plans,
      ),
      sharingRepository: SharingRepository(gateway),
      pendingInvite: PendingInvite(),
    );
  }

  final AppConfig config;
  final ApiGateway apiGateway;
  final SessionStorage sessionStorage;
  final AuthRepository authRepository;

  /// Session state shared by the router and the auth screens.
  final AuthController authController;

  /// The user's plans and the active one, shared by the router and screens.
  final PlansController plansController;

  /// Accounts of the active plan (06, 13, 14, 51, 37).
  final AccountsController accountsController;

  final SharingRepository sharingRepository;

  /// Code of an invitation link opened without a session.
  final PendingInvite pendingInvite;

  LoginController createLoginController() => LoginController(authController);

  RegisterController createRegisterController() =>
      RegisterController(authController);

  HomeController createHomeController() =>
      HomeController(authController, plansController);

  NewPlanController createNewPlanController() =>
      NewPlanController(plansController);

  JoinController createJoinController() =>
      JoinController(sharingRepository, plansController);
}
