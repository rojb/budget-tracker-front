/// Route paths of the app, with the screen numbers of PRD-ux-spec.md §9.1.
abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login'; // 18 Acceso
  static const register = '/register'; // 19 Crear cuenta
  static const welcome = '/welcome'; // 34 Bienvenida
  static const start = '/start'; // signed in without plans

  // Tabs.
  static const home = '/home'; // 01 Inicio
  static const plan = '/plan'; // 06 Plan vacío (02 with add-envelopes)
  static const transactions = '/transactions'; // 10 placeholder
  static const accounts = '/accounts'; // 13 Cuentas

  static const plans = '/plans'; // 16 Planes y miembros
  static const newPlan = '/plans/new'; // 20 Nuevo plan
  static const joinPlan = '/plans/join'; // 30 placeholder
  static const invite = '/plans/invite'; // 21 placeholder
  static const newTransaction = '/transactions/new'; // 07 placeholder
  static const payees = '/payees'; // 15 placeholder
}
