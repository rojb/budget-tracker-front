/// Route paths of the app, with the screen numbers of PRD-ux-spec.md §9.1.
abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login'; // 18 Acceso
  static const register = '/register'; // 19 Crear cuenta
  static const welcome = '/welcome'; // 34 Bienvenida
  static const start = '/start'; // signed in without plans

  // Tabs.
  static const home = '/home'; // 01 Inicio
  static const plan =
      '/plan'; // 06 Plan vacío, or 02 Plan del mes with envelopes
  static const transactions = '/transactions'; // 10 placeholder
  static const accounts = '/accounts'; // 13 Cuentas

  static const plans = '/plans'; // 16 Planes y miembros
  static const newPlan = '/plans/new'; // 20 Nuevo plan
  static const joinPlan = '/plans/join'; // 30 Unirse a un plan
  static const joinLinkPrefix = '/unirse/'; // 45, from sobres.app/unirse/<code>
  static String joinLink(String code) => '$joinLinkPrefix$code';
  static const invite = '/plans/invite'; // 21 Invitar miembro
  static const newTransaction = '/transactions/new'; // 07 placeholder
  static const payees = '/payees'; // 15 Beneficiarios
  static const newPayee = '/payees/new'; // 41 Nuevo beneficiario
  static String payee(String id) => '/payees/$id'; // 41 Editar beneficiario
  static const newAccount = '/accounts/new'; // 28 Nueva cuenta
  static String accountDetail(String id) => '/accounts/$id'; // 14
  static String editAccount(String id) => '/accounts/$id/edit'; // 42
  static String transferFrom(String id) => '/accounts/$id/transfer'; // 29
  static const archivedAccounts = '/accounts/archived'; // 51
  static const groups = '/groups'; // 32 Grupos
  static const template = '/envelopes/template'; // 35 Plantilla sugerida
  static const newEnvelope = '/envelopes/new'; // 31 Nuevo sobre
  static String newEnvelopeIn(String groupId) =>
      '$newEnvelope?groupId=$groupId'; // 31 with the group preselected
  static const assignMoney = '/envelopes/assign'; // 46 Asigná tu dinero
  static String envelopeDetail(String id) =>
      '/envelopes/$id'; // 22 placeholder (add-envelope-goals)
}
