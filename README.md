# budget-tracker-front

Cliente Flutter de **budget-tracker** (presupuesto por sobres, TAP 2026). Cliente delgado: solo
presentación, navegación, estado de interfaz y cliente HTTP; el backend es la fuente de verdad.

Specs, contrato de API (`openapi.yaml`) y flujo de trabajo:
[budget-tracker-specs](https://github.com/rojb/budget-tracker-specs).

## Requisitos

- Flutter en el canal `stable` (probado con 3.47.1, Dart 3.13.1).
- Android SDK (minSdk 26, Android 8.0+) y/o Xcode (iOS 13+). Solo Android e iOS.

## Setup

```bash
flutter pub get
flutter analyze
flutter run
```

La URL de la API se define en tiempo de compilación (por defecto `http://10.0.2.2:3000`, el host
visto desde el emulador de Android):

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000
```

## Estructura

```
lib/
  main.dart            # punto de entrada
  app/                 # App, router (go_router) y raíz de composición (dependencies.dart)
  core/                # configuración (API_BASE_URL vía --dart-define)
  features/<feature>/  # widget contenedor + <feature>_controller.dart (ChangeNotifier)
packages/ui/           # paquete local: solo widgets de presentación
widgetbook/            # app Flutter aparte con el catálogo de packages/ui
```

- Estado: `ChangeNotifier` + `ListenableBuilder`. Sin `provider` ni Riverpod.
- Dependencias: se inyectan por constructor desde `lib/app/dependencies.dart`.
- `packages/ui`: `lib/src/{tokens,atoms,molecules,organisms}` y un único export público,
  `package:ui/ui.dart`. Sus widgets son `StatelessWidget` y no conocen controladores ni la API.

## Regla de dependencias

`app -> packages/ui` y `widgetbook -> packages/ui`, nunca al revés. `packages/ui/pubspec.yaml` no
depende de la app ni de ningún cliente de API, así que importar código de la app desde
`packages/ui` no compila y `flutter analyze` falla.

## Cliente de API generado

`packages/api_client` se genera desde `openapi.yaml` (repo de specs, clonado al lado como `../2do` o
`../budget-tracker-specs`) con OpenAPI Generator `dart-dio`; nunca se edita a mano. La versión del
generador está fijada en `openapitools.json` (necesita Java). Para regenerarlo:

```bash
npx @openapitools/openapi-generator-cli generate
cd packages/api_client && dart pub get && dart run build_runner build --delete-conflicting-outputs
```

Es lo mismo que `npx @openapitools/openapi-generator-cli generate -g dart-dio -i ../2do/openapi.yaml
-o packages/api_client`. Si tu checkout de specs se llama `budget-tracker-specs`, pasá el contrato
con `-i` sin tocar el pin de `openapitools.json`:

```bash
npx @openapitools/openapi-generator-cli generate -g dart-dio \
  -i ../budget-tracker-specs/openapi.yaml -o packages/api_client \
  --additional-properties=pubName=api_client,pubAuthor=budget-tracker
``` Ajustá `inputSpec` en `openapitools.json` si tu checkout del repo de specs
tiene otro nombre. Los `*.g.dart` generados se commitean, y `test/` y `doc/` no se generan (ver
`packages/api_client/README.md`).

## Autenticación y cómo correr la app contra la API

Sesión con un JWT guardado en `flutter_secure_storage`; `go_router` redirige según la sesión
(`lib/app/router.dart`) y `AuthController` (`lib/features/auth`) la maneja. El logout borra el
token. Pantallas: 18 Acceso, 19 Crear cuenta, 34 Bienvenida; 01/02, 20 y 30 son rutas placeholder.

**Contra el backend real** (repo `budget-tracker-back`: `docker compose up -d`,
`npm run migration:run`, `npm run start:dev`) en un dispositivo Android por USB:

```bash
adb reverse tcp:3000 tcp:3000
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

En el emulador alcanza con el valor por defecto (`http://10.0.2.2:3000`). El tráfico HTTP sin TLS
solo está permitido en builds debug (`android/app/src/debug/AndroidManifest.xml`).

**Sin backend, con un mock Prism** generado desde `openapi.yaml`:

```bash
npx @stoplight/prism-cli mock ../2do/openapi.yaml -p 4010
adb reverse tcp:4010 tcp:4010
flutter run --dart-define=API_BASE_URL=http://localhost:4010
```

Prism no valida el JWT ni las credenciales: sirve para los caminos felices (los 401 solo se ven con
el backend real).

## Planes, cuentas y pestañas

Cambio `add-plans-and-accounts` (RRG-46).

- **Pestañas** (`lib/features/shell/app_shell.dart`): `StatefulShellRoute` con Inicio (01, por ahora
  solo el avatar que abre 39 Menú de cuenta), Plan (06 Plan vacío mientras no haya sobres), "+"
  (07, placeholder) y Movimientos (10, placeholder) y Cuentas (13 → 14). El `UiNavCluster` va fijo
  fuera del contenido que scrollea.
- **Plan activo** (`PlansController`, app-scoped): carga `GET /plans` al iniciar sesión, recuerda el
  plan elegido en `flutter_secure_storage` y se limpia al cerrar sesión. Sin planes, el router
  manda a `/start` (crear 20 o unirse 30). Todo monto se formatea con la moneda del plan activo
  (`formatMoney(minor, plans.currency)`).
- **Cuentas** (`AccountsController`, app-scoped): cuentas activas y archivadas del plan activo;
  pantallas 13, 14, 28/42 (mismo formulario), 48 (hoja de confirmación), 51 y el selector 37
  (`showAccountPicker`, para movimientos y transferencias).
- Errores de API mapeados una sola vez en `lib/core/api/api_failure.dart` (400 por campo, 403, 404,
  409, red).
- Pantallas de cambios futuros (07, 10, 15, 21, 29, 30, 31, 32, 35) son rutas placeholder.

## Beneficiarios

Cambio `add-payees` (RRG-48). Desde 39 Menú de cuenta → "Beneficiarios": 15 (lista con búsqueda en
el lugar), 41 (alta y edición) y 47 (hoja de confirmación). La baja es lógica: los movimientos
pasados conservan el beneficiario (FR-05). Un `PayeesController` vive mientras 15 → 41 están
abiertas (`ShellRoute` en `lib/app/router.dart`). El campo "Sobre" de 41 queda en "Sin sobre" hasta
que `add-envelopes` traiga el selector 36, y los contadores de movimientos quedan en 0 hasta
`add-transactions`.

## Planes compartidos

Cambio `add-plan-sharing` (RRG-53). 21 Invitar miembro (desde 16, solo la titular: código, QR con
`qr_flutter`, copiar, compartir con `share_plus`, generar otro, revocar), 30 Unirse a un plan (código
con o sin guion) y 45 Unirse desde enlace. En 16 la titular cambia roles o quita miembros; el resto
puede salir del plan.

El enlace `https://sobres.app/unirse/<code>` abre 45 (intent filter en
`android/app/src/main/AndroidManifest.xml`, `FlutterDeepLinkingEnabled` en iOS). Sin sesión, el
router guarda el código (`PendingInvite`), pasa por 19 (o 18) y después abre 45. Para probarlo en
un dispositivo:

```bash
adb shell am start -a android.intent.action.VIEW -d "https://sobres.app/unirse/K7M4QX"
```

El QR se lee con la cámara del teléfono (abre el enlace); la pestaña "Escanear QR" de 30 lo explica.

## Widgetbook

```bash
cd widgetbook
flutter pub get
flutter run
```

El catálogo se declara a mano en `widgetbook/lib/catalog/directories.dart` (sin generación de
código). Todo componente nuevo o modificado de `packages/ui` lleva su story en el mismo PR.

## Sin tests

Decisión del equipo: este repo no tiene carpetas `test/` ni archivos `*_test.dart`, y `flutter_test`
no está en ningún `pubspec.yaml`. La verificación es manual: Widgetbook contra
`design/screens/NN-*.png` del repo de specs. El CI solo corre `flutter analyze` y
`flutter build apk --debug`.

## Flujo de trabajo

Ramas `rrg-NN-<change>` y Conventional Commits con id de Linear; ver
`docs/COLABORACION.md` en el repo de specs.
