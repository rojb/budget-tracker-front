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
  (07 Nuevo movimiento) y Movimientos (10) y Cuentas (13 → 14). El `UiNavCluster` va fijo
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
- Pantallas de cambios futuros (por ejemplo 22) son rutas placeholder.

## Beneficiarios

Cambio `add-payees` (RRG-48). Desde 39 Menú de cuenta → "Beneficiarios": 15 (lista con búsqueda en
el lugar), 41 (alta y edición) y 47 (hoja de confirmación). La baja es lógica: los movimientos
pasados conservan el beneficiario (FR-05). Un `PayeesController` vive mientras 15 → 41 están
abiertas (`ShellRoute` en `lib/app/router.dart`). El campo "Sobre" de 41 queda en "Sin sobre" hasta
que un cambio lo conecte al selector 36 (`showEnvelopePicker`, que ya trae `add-transactions`; el
back valida el sobre sugerido). Los contadores de movimientos vienen de la API desde
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

## Transferencias

Cambio `add-account-transfers` (RRG-55). Desde 14 Detalle de cuenta → "Transferir" (ícono de
flechas) se abre 29 Transferencia: origen y destino con el selector 37 (nunca ofrece la otra
punta), monto con el teclado, fecha y hora con la hoja 38 (`lib/features/common/date_time_sheet.dart`,
reutilizable por `add-transactions`). 14 lista las transferencias agrupadas por día con `UiTxRow`;
tocar una permite eliminarla. Una transferencia no usa sobres. Con `add-transactions`, 14 junta
además los movimientos de la cuenta (`features/common/day_groups.dart`).

## Sobres y grupos

Cambio `add-envelopes` (RRG-47). `lib/features/envelopes/`:

- **Pestaña Plan** (`PlanTabPage`): 06 Plan vacío mientras el plan no tiene sobres y 02 Plan del mes
  apenas tiene uno. `EnvelopesController` (app-scoped) carga grupos y sobres del plan activo, recarga
  al cambiar de plan y después de cada cambio, porque las cifras (`assignedMinor`, `availableMinor`,
  Listo para asignar) las deriva la API.
- **Pantallas:** 02 (`layers` → 32, lupa que filtra en el lugar, encabezados de grupo con "+" → 31,
  "Sin grupo" al final), 31 Nuevo sobre (con el bloque "Objetivo" de `add-envelope-goals`), 52
  Elegir grupo (hoja con "+ Nuevo grupo" expandible), 32 Grupos (arrastrar para reordenar, lápiz,
  papelera → 44), 35 Plantilla sugerida (la plantilla sale de `GET /envelope-template`), 46 Asigná tu
  dinero (asignación masiva) y las hojas 43 y 44.
- **Límite con `add-monthly-assignment`:** la navegación de meses (las flechas del selector quedan
  deshabilitadas), los chips de estado, el "+" de la tarjeta (→ 03) y el cierre de mes son de ese
  cambio. `EnvelopeRow` ya dibuja Funded, Underfunded, Overspent y Empty; Underfunded lo produce
  `add-envelope-goals`.
- **Entrada a 43:** la papelera de 23 y "Eliminar meta" de 40 (cambio `add-envelope-goals`); la
  pulsación larga provisoria sobre una fila de 02 ya no existe, y tocar la fila abre 22.
- El gasto de cada fila viene de la API (`spentMinor`), así que "<gastado> de <asignado>" refleja los
  movimientos.

## Movimientos

Cambio `add-transactions` (RRG-49). `lib/features/transactions/`:

- **Pantallas:** 07 Nuevo movimiento y 09 Registrar ingreso (`NewTransactionPage`: una sola
  página, el `UiToggle` cambia de modo y conserva lo tipeado), 08 Dividir pago (`SplitPage`, ícono
  de dividir del `SaveBar`), 10 Movimientos (pestaña), y las hojas 36 Elegir sobre
  (`showEnvelopePicker`) y 26 Elegir beneficiario (`showPayeePicker`); 37 y 38 se reutilizan tal
  cual (`showAccountPicker`, `showDateTimeSheet`).
- **Estado:** `TransactionsController` (app-scoped) guarda las páginas cargadas de 10 (más al
  acercarse al final del scroll) y `TransactionDraft` el movimiento que se está armando (07, 09 y
  08 lo comparten). Al guardar se recargan movimientos, sobres y cuentas, porque las cifras las
  deriva la API.
- **Calculadora (FR-18):** `AmountExpression` (Dart puro, sin floats) acepta `+ − × ÷` con
  precedencia, muestra el resultado en la cápsula y la expresión debajo, y redondea al confirmar a
  la unidad menor de la moneda. El teclado es `UiCalculatorPad` (`packages/ui`).
- **Beneficiarios:** escribir un nombre nuevo en 26 lo manda como `payeeName` y la API lo crea al
  guardar; elegir uno con sobre sugerido completa "Sobre" (salvo que ya se haya elegido a mano).
- Las transferencias no aparecen en 10, solo en 14.

### Edición, filtros y deshacer

Cambio `add-transaction-editing-and-filters` (RRG-50):

- **Editar (12):** tocar un movimiento de 10 o de 14 abre `EditTransactionPage`
  (`/transactions/:id/edit`, recibe el `TransactionData` como `extra`). Reutiliza el formulario de 07
  con `TransactionDraft.fromTransaction`: monto con el teclado del `SaveBar`, "Antes $ X", nota
  lavanda "Es de <mes>, un mes cerrado" si el movimiento es de un mes anterior, y papelera → 27. Un
  movimiento dividido se edita en 08 (el `SaveBar` pasa a "Guardar cambios" y vuelve a 12, que envía
  el `PUT`). El `PUT` reemplaza todo el estado, así que deshacer es reenviar el estado anterior.
- **Eliminar (27)** (`showDeleteTransactionSheet`) y **toast de 49** (`showChangeToast`): al volver
  a 10 / 14 el toast Neutral dice "Recalculado" o "Movimiento eliminado", nombra los meses que
  devolvió la API (`affectedMonths`) y ofrece "Deshacer": reenvía el estado anterior (edición) o llama
  a `restore` (baja lógica). Una edición cuyo original tenía una porción sin sobre no se puede
  reenviar y el toast no ofrece "Deshacer".
- **Filtros (11) y búsqueda:** `TransactionFilter` (fechas, franja horaria, tipo, beneficiario, sobre,
  cuenta y texto) vive en `TransactionsController`, que recarga desde la primera página al cambiarlo y
  guarda el `summary` de la API. 10 muestra la lupa (campo en el lugar), el botón de filtros
  (lavanda con filtros activos), un chip quitable por filtro y, con filtros o búsqueda, la tarjeta
  "Salió en la franja / Entró". 11 (`showFilterSheet`) cuenta en vivo "Ver N movimientos"; las hojas de
  fecha y hora son variantes de 38 (`features/common/date_sheets.dart`). Cerrar la hoja aplica lo
  elegido.

## Metas, detalle de sobre y mover dinero

Cambio `add-envelope-goals` (RRG-52). `lib/features/envelopes/` y `lib/features/goals/`:

- **El cliente no calcula estados.** `EnvelopeLineData` trae `state` (`funded`, `underfunded`,
  `overspent`) y, con meta, `goalStatus` (requerido del mes, lo que falta, ahorrado, porcentaje, meses
  restantes) tal como los devuelve la API; `goal_texts.dart` solo arma los textos ("Falta $ X",
  "Cubierto", "Objetivo mensual · 100% asignado", "3 meses restantes"). 02 usa ese estado para sus
  filas (Funded, Underfunded, Overspent; las rayas son la cobertura del requerido del mes si hay meta,
  o lo gastado si no).
- **22 Detalle de sobre** (`/envelopes/:id`): cifras del mes, fila de objetivo (`UiGoalRow`) y la
  actividad del mes de `GET .../detail` (tocar un movimiento abre 12). El lápiz (→ 23) y "Mover
  dinero" (→ 24) no se muestran a quien solo lee.
- **23 Editar sobre** (`/envelopes/:id/edit`) y el bloque "Objetivo" de **31**: `GoalFields` (chips
  Sin objetivo / Mensual / Con fecha, la cápsula con teclado para un monto propio, montos rápidos y
  "Fecha límite"). Guardar manda nombre, grupo e ícono con `PATCH` y la meta con `PUT` o `DELETE`.
  La papelera de 23 (→ 43) es la única entrada al borrado.
- **24 Mover dinero** (`/envelopes/:id/move`): el origen es el sobre desde el que se abrió; si el
  destino está sobregirado el monto empieza en su sobregiro (tope: lo que tiene el origen). El
  `SaveBar` queda deshabilitado con el motivo ("Elegí un sobre", "Ingresá un monto", "Supera lo
  disponible"); la API responde 409 si el dinero cambió.
- **01 Inicio**: carrusel "Metas" con una `UiGoalCard` por cada sobre con meta con fecha (→ 05) y
  "+ Nueva meta" (→ 31 con el grupo Metas y "Con fecha"); estados vacío ("Creá tu primera meta"),
  cargando y error. La tarjeta "Listo para asignar" y Reportes no están (`add-monthly-assignment` y
  `add-reports`).
- **05 Detalle de meta** (`/goals/:id`), **40 Opciones de meta** y **50 Foto de la meta**: foto a
  pantalla completa (o el tinte lavanda con el ícono) bajo paneles de vidrio, tiles a 22, 24 y 23, y
  "Asignar a esta meta" deshabilitado hasta que exista 03. 50 elige de la galería o la cámara
  (`image_picker`), una foto sugerida, o quita la foto; "Listo" la sube (la API valida JPEG/PNG/WebP de
  hasta 5 MB). Desde 31 solo recuerda la elección y se aplica al crear el sobre.
- **Fotos con autenticación.** La API sirve las fotos solo a miembros: `EnvelopesController.imageFor`
  arma un `NetworkImage` con el header `Authorization` de `ApiGateway`. Una foto nueva cambia su URL
  (`?v=`), así que el caché de imágenes de Flutter no muestra una vieja.
- Mes: todas las pantallas usan el mes cargado por `EnvelopesController` (el actual); la navegación
  de meses es de `add-monthly-assignment`.

## Plan del mes, asignación y cierre de mes

Cambio `add-monthly-assignment` (RRG-51). `lib/features/plan/`:

- **Mes visto.** `EnvelopesController.showMonth` carga las cifras de otro mes y las recargas siguientes
  lo mantienen, así 22 y 24 ven el mismo mes que 02. `MonthController` (app-scoped) sigue esas
  cargas, pide el resumen del mes (`GET /plans/:id/months/:month`: mes actual del plan, si es futuro)
  y guarda el filtro de estado.
- **02 / 04.** ‹ › cambian de mes sin límite (FR-15). Los chips "Todos · Sobregirados · Falta ·
  Cubiertos" filtran en el lugar por el `state` de la API (Cubiertos = cubiertos con dinero; un sobre
  sin nada es Empty). En un mes futuro la vista pasa a 04: aviso lavanda con "Hoy", encabezados con
  "$ X asignado" y filas "Reservado desde <mes actual>" o "Sin asignar todavía".
- **03 / 53 Asignar dinero** (`/assign?month=&envelopeId=`): desde el "+" de 01, 02 y 04 y desde
  "Asignar a esta meta" de 05. Monto (arranca en lo que necesita el sobre elegido: su sobregiro o lo
  que le falta a su meta), montos rápidos, el mes visto y los tres siguientes, y el carrusel de sobres
  (`UiAssignCard`). La cápsula o la calculadora del `SaveBar` pasan a 53, con `UiCalculatorPad` y
  `AmountExpression` (FR-18). Confirmar suma el monto a la asignación del sobre en ese mes
  (`POST .../months/:month/assignments`) y vuelve a la vista de ese mes; con 0 dice "Ingresá un monto
  mayor a cero" y si Listo para asignar queda negativo avisa "Asignaste más de lo disponible".
- **25 Cierre de mes** (`/month-close/:month`): se abre solo al ver el mes actual cuando el cierre del
  mes anterior mueve dinero y nadie lo confirmó (una vez por sesión; no se abre a quien solo lee).
  Lista lo que se arrastra y lo que se descuenta (`UiCloseRow`), el cuadre con `UiBalanceCheck` y
  "Empezar <mes>", que confirma el cierre (`POST .../close`) y muestra el toast "Mes de <mes>
  abierto". La cruz lo deja pendiente.

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
