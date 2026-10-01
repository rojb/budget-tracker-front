// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_suggestion.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PhotoSuggestion extends PhotoSuggestion {
  @override
  final PhotoSuggestionId id;
  @override
  final String name;
  @override
  final String imageUrl;

  factory _$PhotoSuggestion([void Function(PhotoSuggestionBuilder)? updates]) =>
      (PhotoSuggestionBuilder()..update(updates))._build();

  _$PhotoSuggestion._(
      {required this.id, required this.name, required this.imageUrl})
      : super._();
  @override
  PhotoSuggestion rebuild(void Function(PhotoSuggestionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PhotoSuggestionBuilder toBuilder() => PhotoSuggestionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PhotoSuggestion &&
        id == other.id &&
        name == other.name &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PhotoSuggestion')
          ..add('id', id)
          ..add('name', name)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class PhotoSuggestionBuilder
    implements Builder<PhotoSuggestion, PhotoSuggestionBuilder> {
  _$PhotoSuggestion? _$v;

  PhotoSuggestionId? _id;
  PhotoSuggestionId? get id => _$this._id;
  set id(PhotoSuggestionId? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  PhotoSuggestionBuilder() {
    PhotoSuggestion._defaults(this);
  }

  PhotoSuggestionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PhotoSuggestion other) {
    _$v = other as _$PhotoSuggestion;
  }

  @override
  void update(void Function(PhotoSuggestionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PhotoSuggestion build() => _build();

  _$PhotoSuggestion _build() {
    final _$result = _$v ??
        _$PhotoSuggestion._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'PhotoSuggestion', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'PhotoSuggestion', 'name'),
          imageUrl: BuiltValueNullFieldError.checkNotNull(
              imageUrl, r'PhotoSuggestion', 'imageUrl'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
