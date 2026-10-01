// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_photo_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SuggestedPhotoRequest extends SuggestedPhotoRequest {
  @override
  final PhotoSuggestionId suggestionId;

  factory _$SuggestedPhotoRequest(
          [void Function(SuggestedPhotoRequestBuilder)? updates]) =>
      (SuggestedPhotoRequestBuilder()..update(updates))._build();

  _$SuggestedPhotoRequest._({required this.suggestionId}) : super._();
  @override
  SuggestedPhotoRequest rebuild(
          void Function(SuggestedPhotoRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SuggestedPhotoRequestBuilder toBuilder() =>
      SuggestedPhotoRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SuggestedPhotoRequest && suggestionId == other.suggestionId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, suggestionId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SuggestedPhotoRequest')
          ..add('suggestionId', suggestionId))
        .toString();
  }
}

class SuggestedPhotoRequestBuilder
    implements Builder<SuggestedPhotoRequest, SuggestedPhotoRequestBuilder> {
  _$SuggestedPhotoRequest? _$v;

  PhotoSuggestionId? _suggestionId;
  PhotoSuggestionId? get suggestionId => _$this._suggestionId;
  set suggestionId(PhotoSuggestionId? suggestionId) =>
      _$this._suggestionId = suggestionId;

  SuggestedPhotoRequestBuilder() {
    SuggestedPhotoRequest._defaults(this);
  }

  SuggestedPhotoRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _suggestionId = $v.suggestionId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SuggestedPhotoRequest other) {
    _$v = other as _$SuggestedPhotoRequest;
  }

  @override
  void update(void Function(SuggestedPhotoRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SuggestedPhotoRequest build() => _build();

  _$SuggestedPhotoRequest _build() {
    final _$result = _$v ??
        _$SuggestedPhotoRequest._(
          suggestionId: BuiltValueNullFieldError.checkNotNull(
              suggestionId, r'SuggestedPhotoRequest', 'suggestionId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
