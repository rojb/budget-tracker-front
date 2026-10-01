// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransactionPage extends TransactionPage {
  @override
  final TransactionSummary summary;
  @override
  final BuiltList<Transaction> items;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int total;

  factory _$TransactionPage([void Function(TransactionPageBuilder)? updates]) =>
      (TransactionPageBuilder()..update(updates))._build();

  _$TransactionPage._(
      {required this.summary,
      required this.items,
      required this.page,
      required this.pageSize,
      required this.total})
      : super._();
  @override
  TransactionPage rebuild(void Function(TransactionPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionPageBuilder toBuilder() => TransactionPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionPage &&
        summary == other.summary &&
        items == other.items &&
        page == other.page &&
        pageSize == other.pageSize &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionPage')
          ..add('summary', summary)
          ..add('items', items)
          ..add('page', page)
          ..add('pageSize', pageSize)
          ..add('total', total))
        .toString();
  }
}

class TransactionPageBuilder
    implements
        Builder<TransactionPage, TransactionPageBuilder>,
        PageMetaBuilder {
  _$TransactionPage? _$v;

  TransactionSummaryBuilder? _summary;
  TransactionSummaryBuilder get summary =>
      _$this._summary ??= TransactionSummaryBuilder();
  set summary(covariant TransactionSummaryBuilder? summary) =>
      _$this._summary = summary;

  ListBuilder<Transaction>? _items;
  ListBuilder<Transaction> get items =>
      _$this._items ??= ListBuilder<Transaction>();
  set items(covariant ListBuilder<Transaction>? items) => _$this._items = items;

  int? _page;
  int? get page => _$this._page;
  set page(covariant int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(covariant int? pageSize) => _$this._pageSize = pageSize;

  int? _total;
  int? get total => _$this._total;
  set total(covariant int? total) => _$this._total = total;

  TransactionPageBuilder() {
    TransactionPage._defaults(this);
  }

  TransactionPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _summary = $v.summary.toBuilder();
      _items = $v.items.toBuilder();
      _page = $v.page;
      _pageSize = $v.pageSize;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant TransactionPage other) {
    _$v = other as _$TransactionPage;
  }

  @override
  void update(void Function(TransactionPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionPage build() => _build();

  _$TransactionPage _build() {
    _$TransactionPage _$result;
    try {
      _$result = _$v ??
          _$TransactionPage._(
            summary: summary.build(),
            items: items.build(),
            page: BuiltValueNullFieldError.checkNotNull(
                page, r'TransactionPage', 'page'),
            pageSize: BuiltValueNullFieldError.checkNotNull(
                pageSize, r'TransactionPage', 'pageSize'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'TransactionPage', 'total'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'summary';
        summary.build();
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TransactionPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
