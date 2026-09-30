import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Named aliases over the Lucide icon set, stroke weight 300 (= 1.5 stroke,
/// PRD-ux-spec.md section 7). Components import only this class, so swapping
/// the icon source is a one-file change.
abstract final class UiIcons {
  static const IconData house = LucideIcons.house300;
  static const IconData wallet = LucideIcons.wallet300;
  static const IconData arrowLeftRight = LucideIcons.arrowLeftRight300;
  static const IconData creditCard = LucideIcons.creditCard300;
  static const IconData plus = LucideIcons.plus300;
  static const IconData star = LucideIcons.star300;
  static const IconData sparkles = LucideIcons.sparkles300;
  static const IconData check = LucideIcons.check300;
  static const IconData calculator = LucideIcons.calculator300;
  static const IconData lock = LucideIcons.lock300;
  static const IconData mail = LucideIcons.mail300;
  static const IconData eye = LucideIcons.eye300;
  static const IconData eyeOff = LucideIcons.eyeOff300;
  static const IconData user = LucideIcons.user300;
  static const IconData circleAlert = LucideIcons.circleAlert300;
  static const IconData qrCode = LucideIcons.qrCode300;
  static const IconData camera = LucideIcons.camera300;
  static const IconData logOut = LucideIcons.logOut300;
  static const IconData chevronRight = LucideIcons.chevronRight300;
  static const IconData delete = LucideIcons.delete300;
  static const IconData undo = LucideIcons.rotateCcw300;
  static const IconData info = LucideIcons.info300;
  static const IconData warning = LucideIcons.triangleAlert300;
  static const IconData error = LucideIcons.circleX300;
  static const IconData chevronLeft = LucideIcons.chevronLeft300;
  static const IconData close = LucideIcons.x300;
  static const IconData search = LucideIcons.search300;
  static const IconData layers = LucideIcons.layers300;
  static const IconData pencil = LucideIcons.pencil300;
  static const IconData archive = LucideIcons.archive300;
  static const IconData landmark = LucideIcons.landmark300;
  static const IconData smartphone = LucideIcons.smartphone300;
  static const IconData banknote = LucideIcons.banknote300;
  static const IconData keyRound = LucideIcons.keyRound300;
  static const IconData contact = LucideIcons.squareUserRound300;
  static const IconData cornerDownRight = LucideIcons.cornerDownRight300;
  static const IconData wand = LucideIcons.wandSparkles300;
  static const IconData userPlus = LucideIcons.userPlus300;
  static const IconData lightbulb = LucideIcons.lightbulb300;
  static const IconData history = LucideIcons.history300;
  static const IconData trash = LucideIcons.trash2300;
  static const IconData copy = LucideIcons.copy300;
  static const IconData share = LucideIcons.share2300;
  static const IconData refresh = LucideIcons.refreshCw300;
  static const IconData hash = LucideIcons.hash300;
  static const IconData logIn = LucideIcons.logIn300;
  static const IconData chevronDown = LucideIcons.chevronDown300;
  static const IconData chevronUp = LucideIcons.chevronUp300;
  static const IconData arrowDown = LucideIcons.arrowDown300;
  static const IconData clock = LucideIcons.clock300;

  // Envelope icons (the API's closed `EnvelopeIcon` set, plus the two helpers of 31 and 32).
  static const IconData tag = LucideIcons.tag300;
  static const IconData bus = LucideIcons.bus300;
  static const IconData utensils = LucideIcons.utensils300;
  static const IconData heartPulse = LucideIcons.heartPulse300;
  static const IconData gift = LucideIcons.gift300;
  static const IconData cart = LucideIcons.shoppingCart300;
  static const IconData pill = LucideIcons.pill300;
  static const IconData wifi = LucideIcons.wifi300;
  static const IconData settings = LucideIcons.settings300;
  static const IconData ticket = LucideIcons.ticket300;
  static const IconData repeat = LucideIcons.repeat300;
  static const IconData lifeBuoy = LucideIcons.lifeBuoy300;
  static const IconData plane = LucideIcons.plane300;
  static const IconData ellipsis = LucideIcons.ellipsis300;
  static const IconData grip = LucideIcons.gripVertical300;

  // Movements (07, 08, 09, 10).
  static const IconData split = LucideIcons.split300;
  static const IconData inbox = LucideIcons.inbox300;
  static const IconData arrowDownLeft = LucideIcons.arrowDownLeft300;
}

/// Icon of each envelope icon name of the API (`EnvelopeIcon`), in the order
/// the icon selector of 31 shows them.
const Map<String, IconData> uiEnvelopeIcons = {
  'tag': UiIcons.tag,
  'home': UiIcons.house,
  'bus': UiIcons.bus,
  'utensils': UiIcons.utensils,
  'heartPulse': UiIcons.heartPulse,
  'gift': UiIcons.gift,
  'cart': UiIcons.cart,
  'pill': UiIcons.pill,
  'wifi': UiIcons.wifi,
  'settings': UiIcons.settings,
  'ticket': UiIcons.ticket,
  'repeat': UiIcons.repeat,
  'lifeBuoy': UiIcons.lifeBuoy,
  'plane': UiIcons.plane,
};

/// Glyph for an envelope icon name, `tag` when the name is unknown.
IconData uiEnvelopeIcon(String? name) => uiEnvelopeIcons[name] ?? UiIcons.tag;
