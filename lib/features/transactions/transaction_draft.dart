import 'package:flutter/foundation.dart';
import 'package:ui/ui.dart';

import 'amount_expression.dart';
import 'transactions_repository.dart';

/// The payee chosen in 26: an existing one ([id]) or a name typed in "Crear …"
/// that the API creates when the movement is saved.
class PayeePick {
  const PayeePick({required this.name, this.id, this.suggestedEnvelopeId});

  final String? id;
  final String name;
  final String? suggestedEnvelopeId;
}

/// One portion of a split expense in 08.
class SplitPart {
  SplitPart({required this.amountMinor, this.envelopeId});

  String? envelopeId;
  int amountMinor;
}

/// The movement being typed. 07 and 09 are two views of it (the toggle only
/// flips [isExpense]) and 08 edits its [splits], so going back and forth keeps
/// everything the user entered.
class TransactionDraft extends ChangeNotifier {
  TransactionDraft({required this.currency, this.accountId});

  final Currency currency;
  final AmountExpression amount = AmountExpression();

  bool isExpense = true;
  PayeePick? payee;
  String? accountId;
  DateTime occurredAt = DateTime.now();
  String description = '';

  /// Envelope of an expense; [envelopeByHand] stops a payee's suggested
  /// envelope from overriding it.
  String? envelopeId;
  bool envelopeByHand = false;

  /// Income: directly to [incomeEnvelopeId] instead of Ready to Assign.
  bool incomeToEnvelope = false;
  String? incomeEnvelopeId;

  /// Portions of a split expense (08); empty until 08 opens.
  List<SplitPart> splits = [];

  int get minorUnits => currency.minorUnits;

  /// Result of the amount expression in minor units; null when empty or
  /// invalid.
  int? get amountMinor => amount.minor(minorUnits);

  void _changed() => notifyListeners();

  void setDirection({required bool expense}) {
    if (isExpense == expense) return;
    isExpense = expense;
    _changed();
  }

  void typeDigits(String digits) {
    amount.digit(digits);
    _changed();
  }

  void typeDecimal() {
    amount.decimal();
    _changed();
  }

  void typeOperator(String operator) {
    amount.operator(operator);
    _changed();
  }

  void typeDelete() {
    amount.delete();
    _changed();
  }

  /// Chooses the payee (or clears it with null). An expense without an
  /// envelope chosen by hand takes the payee's suggested one (FR-23).
  void pickPayee(PayeePick? pick, {bool suggestionExists = true}) {
    payee = pick;
    final suggested = pick?.suggestedEnvelopeId;
    if (isExpense && !envelopeByHand && suggested != null && suggestionExists) {
      envelopeId = suggested;
    }
    _changed();
  }

  void pickEnvelope(String id) {
    if (isExpense) {
      envelopeId = id;
      envelopeByHand = true;
    } else {
      incomeEnvelopeId = id;
      incomeToEnvelope = true;
    }
    _changed();
  }

  void chooseReadyToAssign() {
    incomeToEnvelope = false;
    _changed();
  }

  void chooseIncomeEnvelope() {
    incomeToEnvelope = true;
    _changed();
  }

  void setAccount(String id) {
    accountId = id;
    _changed();
  }

  void setOccurredAt(DateTime value) {
    occurredAt = value;
    _changed();
  }

  void setDescription(String value) {
    description = value.trim();
    _changed();
  }

  /// First error that stops saving from 07 / 09, or null when it can be saved.
  String? validate() {
    if (accountId == null) return 'Elegí una cuenta.';
    if (amount.isInvalid(minorUnits)) return 'Revisá la operación.';
    final value = amountMinor;
    if (value == null || value <= 0) return 'Ingresá un monto mayor a cero.';
    if (isExpense && envelopeId == null) return 'Elegí un sobre.';
    if (!isExpense && incomeToEnvelope && incomeEnvelopeId == null) {
      return 'Elegí un sobre.';
    }
    return null;
  }

  NewTransaction build() {
    return NewTransaction(
      isExpense: isExpense,
      accountId: accountId!,
      amountMinor: amountMinor!,
      occurredAt: occurredAt,
      payeeId: payee?.id,
      payeeName: payee != null && payee!.id == null ? payee!.name : null,
      description: description.isEmpty ? null : description,
      envelopeId: isExpense
          ? envelopeId
          : (incomeToEnvelope ? incomeEnvelopeId : null),
    );
  }

  // --- Split (08) ---------------------------------------------------------

  /// Starts the split with the envelope chosen in 07 carrying the whole amount.
  void startSplit() {
    if (splits.isNotEmpty) return;
    splits = [SplitPart(envelopeId: envelopeId, amountMinor: amountMinor ?? 0)];
    _changed();
  }

  int get splitDistributed =>
      splits.fold(0, (sum, part) => sum + part.amountMinor);

  /// Positive: still to distribute; negative: the parts exceed the total.
  int get splitRemaining => (amountMinor ?? 0) - splitDistributed;

  bool get splitValid =>
      splits.length >= 2 &&
      splits.every((p) => p.envelopeId != null && p.amountMinor > 0) &&
      splitRemaining == 0;

  void setSplitAmount(int index, int minor) {
    splits[index].amountMinor = minor;
    _changed();
  }

  void setSplitEnvelope(int index, String id) {
    splits[index].envelopeId = id;
    _changed();
  }

  /// Adds a portion of what is left to distribute (nothing when it is 0 or less).
  void addSplit(String envelopeId) {
    final left = splitRemaining;
    splits.add(
      SplitPart(envelopeId: envelopeId, amountMinor: left > 0 ? left : 0),
    );
    _changed();
  }

  void removeSplit(int index) {
    splits.removeAt(index);
    _changed();
  }

  void clearSplit() {
    splits = [];
    _changed();
  }

  NewTransaction buildSplit() {
    final base = build();
    return NewTransaction(
      isExpense: true,
      accountId: base.accountId,
      amountMinor: base.amountMinor,
      occurredAt: base.occurredAt,
      payeeId: base.payeeId,
      payeeName: base.payeeName,
      description: base.description,
      splits: [
        for (final part in splits)
          (envelopeId: part.envelopeId!, amountMinor: part.amountMinor),
      ],
    );
  }
}
