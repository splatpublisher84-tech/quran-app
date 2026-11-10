// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_translation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuranTranslation {

 QuranLanguage get language; String get title; String get version;
/// Create a copy of QuranTranslation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranTranslationCopyWith<QuranTranslation> get copyWith => _$QuranTranslationCopyWithImpl<QuranTranslation>(this as QuranTranslation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranTranslation&&(identical(other.language, language) || other.language == language)&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,language,title,version);

@override
String toString() {
  return 'QuranTranslation(language: $language, title: $title, version: $version)';
}


}

/// @nodoc
abstract mixin class $QuranTranslationCopyWith<$Res>  {
  factory $QuranTranslationCopyWith(QuranTranslation value, $Res Function(QuranTranslation) _then) = _$QuranTranslationCopyWithImpl;
@useResult
$Res call({
 QuranLanguage language, String title, String version
});




}
/// @nodoc
class _$QuranTranslationCopyWithImpl<$Res>
    implements $QuranTranslationCopyWith<$Res> {
  _$QuranTranslationCopyWithImpl(this._self, this._then);

  final QuranTranslation _self;
  final $Res Function(QuranTranslation) _then;

/// Create a copy of QuranTranslation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? title = null,Object? version = null,}) {
  return _then(QuranTranslation(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as QuranLanguage,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranTranslation].
extension QuranTranslationPatterns on QuranTranslation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranTranslation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranTranslation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranTranslation value)  $default,){
final _that = this;
switch (_that) {
case _QuranTranslation():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranTranslation value)?  $default,){
final _that = this;
switch (_that) {
case _QuranTranslation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuranLanguage language,  String title,  String version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranTranslation() when $default != null:
return $default(_that.language,_that.title,_that.version);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuranLanguage language,  String title,  String version)  $default,) {final _that = this;
switch (_that) {
case _QuranTranslation():
return $default(_that.language,_that.title,_that.version);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuranLanguage language,  String title,  String version)?  $default,) {final _that = this;
switch (_that) {
case _QuranTranslation() when $default != null:
return $default(_that.language,_that.title,_that.version);case _:
  return null;

}
}

}

/// @nodoc


class _QuranTranslation extends QuranTranslation {
  const _QuranTranslation({required this.language, required this.title, required this.version}): super._();
  

@override final  QuranLanguage language;
@override final  String title;
@override final  String version;

/// Create a copy of QuranTranslation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranTranslationCopyWith<_QuranTranslation> get copyWith => __$QuranTranslationCopyWithImpl<_QuranTranslation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranTranslation&&(identical(other.language, language) || other.language == language)&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,language,title,version);

@override
String toString() {
  return 'QuranTranslation(language: $language, title: $title, version: $version)';
}


}

/// @nodoc
abstract mixin class _$QuranTranslationCopyWith<$Res> implements $QuranTranslationCopyWith<$Res> {
  factory _$QuranTranslationCopyWith(_QuranTranslation value, $Res Function(_QuranTranslation) _then) = __$QuranTranslationCopyWithImpl;
@override @useResult
$Res call({
 QuranLanguage language, String title, String version
});




}
/// @nodoc
class __$QuranTranslationCopyWithImpl<$Res>
    implements _$QuranTranslationCopyWith<$Res> {
  __$QuranTranslationCopyWithImpl(this._self, this._then);

  final _QuranTranslation _self;
  final $Res Function(_QuranTranslation) _then;

/// Create a copy of QuranTranslation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? title = null,Object? version = null,}) {
  return _then(_QuranTranslation(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as QuranLanguage,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
