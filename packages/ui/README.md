# ui

Sistema de diseño de **budget-tracker**: tokens y componentes de presentación. Fuente de verdad
visual: `PRD-ux-spec.md` §7 (tokens) y §8 (componentes) en el repo de specs, y los renders en
`design/screens/`. Solo `StatelessWidget` (con estado interno únicamente para gestos, foco o
temporizadores); sin lógica de negocio, sin controladores, sin cliente de API.

```dart
import 'package:ui/ui.dart'; // único export público
```

## Tema

`buildUiTheme()` devuelve el `ThemeData` con los tokens y la extensión `UiTheme`
(`context.ui.lavender`, etc.). La fuente **Urbanist** viaja dentro del paquete
(`assets/fonts/`, licencia OFL incluida); no se descarga en runtime. La barra de estado la dibuja
el sistema operativo: usá `UiOverlay.onLight` / `UiOverlay.onPhoto` para el color de sus íconos.

## Estructura

```
lib/src/
  tokens/      colors, typography, shape, icons (Lucide, trazo 1.5), theme
  atoms/       UiIconButton, UiButton, UiChip, UiAvatar, UiKey, UiToggle
  molecules/   UiTextField, UiFieldRow, UiAmountCapsule, UiToast (+ showUiToast)
  organisms/   UiNavCluster, UiSaveBar
  format/      money.dart (Currency, formatMoney)
```

## Componentes

| Componente | Variantes |
|---|---|
| `UiIconButton` | white, black, lavender, chartreuse, soft, glass, danger |
| `UiButton` | primary, secondary |
| `UiChip` | default, selected, con check; alto 44 o 34 (compacto) |
| `UiAvatar` | iniciales |
| `UiKey` | number, operator, del |
| `UiToggle` | Gasto / Ingreso (controlado) |
| `UiTextField` | default, focus (automático), error (con mensaje) |
| `UiFieldRow` | etiqueta + valor + chevron |
| `UiAmountCapsule` | símbolo de moneda configurable |
| `UiToast` | neutral, success, info, warning, error; `showUiToast` (uno a la vez, 4 s, se descarta deslizando) |
| `UiNavCluster` | 4 pestañas + acción "+" |
| `UiSaveBar` | default (deslizar o tocar la manija) y disabled (`enabled: false`) |

Los nombres llevan prefijo `Ui` para no chocar con `IconButton`, `Chip`, `TextField` y `Key` de
Flutter. Toda área tocable mide al menos 48 x 48 dp.

## Montos

```dart
formatMoney(48200, Currency.ars);   // $ 48.200
formatMoney(125050, Currency.usd);  // US$ 1.250,50
formatMoney(98000, Currency.eur);   // € 980,00
formatMoney(-1250, Currency.usd);   // −US$ 12,50
```

El monto llega en unidades menores (entero) y el formato es es-AR; ninguna pantalla debe armar
strings de dinero a mano.

## Cómo agregar o modificar un componente

1. PR chica y separada a `packages/ui` (no la mezcles con la pantalla que lo necesita), revisada
   por la otra persona del equipo.
2. Solo tokens de `PRD-ux-spec.md` §7; no inventes colores ni tamaños. Los colores salen de
   `UiColors`, los íconos de `UiIcons`.
3. Un archivo en `atoms/`, `molecules/` u `organisms/` según su composición, exportado desde
   `lib/ui.dart`.
4. Una story de Widgetbook por variante en `widgetbook/lib/catalog/`.
5. Compará la story con `design/screens/NN-*.png` y corré `flutter analyze` en `packages/ui`,
   `widgetbook/` y la app. Sin archivos de test.

Los componentes de dominio (`EnvelopeRow`, `TxRow`, `AccountRow`, etc.) se agregan con el change
que los necesita, siguiendo estos mismos pasos.
