// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add($Account.serializer)
      ..add($AffectedMonths.serializer)
      ..add($PageMeta.serializer)
      ..add(AccountDetail.serializer)
      ..add(AccountType.serializer)
      ..add(ApplyEnvelopeTemplateRequest.serializer)
      ..add(AssignMoneyRequest.serializer)
      ..add(AssignMoneyResult.serializer)
      ..add(AuthSession.serializer)
      ..add(CloseLine.serializer)
      ..add(CreateAccountRequest.serializer)
      ..add(CreateEnvelopeGroupRequest.serializer)
      ..add(CreateEnvelopeRequest.serializer)
      ..add(CreateInvitationRequest.serializer)
      ..add(CreatePayeeRequest.serializer)
      ..add(CreatePlanRequest.serializer)
      ..add(CreateTransactionRequest.serializer)
      ..add(CreateTransactionSplit.serializer)
      ..add(CreateTransferRequest.serializer)
      ..add(Currency.serializer)
      ..add(CurrencyCode.serializer)
      ..add(CurrencyMinorUnitsEnum.serializer)
      ..add(CurrencyNameEnum.serializer)
      ..add(CurrencySymbolEnum.serializer)
      ..add(Envelope.serializer)
      ..add(EnvelopeDetail.serializer)
      ..add(EnvelopeGoal.serializer)
      ..add(EnvelopeGoalType.serializer)
      ..add(EnvelopeGroup.serializer)
      ..add(EnvelopeIcon.serializer)
      ..add(EnvelopeLine.serializer)
      ..add(EnvelopeList.serializer)
      ..add(EnvelopeSpending.serializer)
      ..add(EnvelopeState.serializer)
      ..add(EnvelopeTemplate.serializer)
      ..add(EnvelopeTemplateResult.serializer)
      ..add(Error.serializer)
      ..add(ErrorMessage.serializer)
      ..add(GoalStatus.serializer)
      ..add(HealthStatus.serializer)
      ..add(HealthStatusStatusEnum.serializer)
      ..add(IncomeExpenseMonth.serializer)
      ..add(IncomeExpenseReport.serializer)
      ..add(InitialAssignment.serializer)
      ..add(InitialAssignmentRequest.serializer)
      ..add(InitialAssignmentResult.serializer)
      ..add(Invitation.serializer)
      ..add(InvitationPreview.serializer)
      ..add(InvitationRole.serializer)
      ..add(LoginRequest.serializer)
      ..add(MonthClose.serializer)
      ..add(MonthSummary.serializer)
      ..add(MoveMoneyRequest.serializer)
      ..add(MoveMoneyResult.serializer)
      ..add(NetWorthMonth.serializer)
      ..add(NetWorthReport.serializer)
      ..add(Payee.serializer)
      ..add(PayeePage.serializer)
      ..add(PhotoSuggestion.serializer)
      ..add(PhotoSuggestionId.serializer)
      ..add(Plan.serializer)
      ..add(PlanMember.serializer)
      ..add(PlanRole.serializer)
      ..add(RegisterRequest.serializer)
      ..add(ReorderEnvelopeGroupsRequest.serializer)
      ..add(ReorderEnvelopesRequest.serializer)
      ..add(SpendingMonth.serializer)
      ..add(SpendingReport.serializer)
      ..add(SuggestedPhotoRequest.serializer)
      ..add(TemplateEnvelope.serializer)
      ..add(TemplateGroup.serializer)
      ..add(Transaction.serializer)
      ..add(TransactionChange.serializer)
      ..add(TransactionDirection.serializer)
      ..add(TransactionPage.serializer)
      ..add(TransactionSplit.serializer)
      ..add(TransactionSummary.serializer)
      ..add(Transfer.serializer)
      ..add(TransferPage.serializer)
      ..add(UpdateAccountRequest.serializer)
      ..add(UpdateEnvelopeGroupRequest.serializer)
      ..add(UpdateEnvelopeRequest.serializer)
      ..add(UpdateMemberRequest.serializer)
      ..add(UpdatePayeeRequest.serializer)
      ..add(UpdatePlanRequest.serializer)
      ..add(User.serializer)
      ..add(ValidationError.serializer)
      ..add(ValidationErrorErrorEnum.serializer)
      ..add(ValidationErrorStatusCodeEnum.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CloseLine)]),
          () => ListBuilder<CloseLine>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CloseLine)]),
          () => ListBuilder<CloseLine>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(CreateTransactionSplit)]),
          () => ListBuilder<CreateTransactionSplit>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(EnvelopeGroup)]),
          () => ListBuilder<EnvelopeGroup>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Envelope)]),
          () => ListBuilder<Envelope>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(EnvelopeLine)]),
          () => ListBuilder<EnvelopeLine>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(EnvelopeSpending)]),
          () => ListBuilder<EnvelopeSpending>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(IncomeExpenseMonth)]),
          () => ListBuilder<IncomeExpenseMonth>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(InitialAssignment)]),
          () => ListBuilder<InitialAssignment>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(NetWorthMonth)]),
          () => ListBuilder<NetWorthMonth>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Payee)]),
          () => ListBuilder<Payee>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(PlanMember)]),
          () => ListBuilder<PlanMember>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SpendingMonth)]),
          () => ListBuilder<SpendingMonth>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TemplateEnvelope)]),
          () => ListBuilder<TemplateEnvelope>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TemplateGroup)]),
          () => ListBuilder<TemplateGroup>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Transaction)]),
          () => ListBuilder<Transaction>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Transaction)]),
          () => ListBuilder<Transaction>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TransactionSplit)]),
          () => ListBuilder<TransactionSplit>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Transfer)]),
          () => ListBuilder<Transfer>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
