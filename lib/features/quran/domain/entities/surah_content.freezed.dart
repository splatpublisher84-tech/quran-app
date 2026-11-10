// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurahContent {

 Surah get surah; QuranLanguage get language; List<Ayah> get ayahs;
/// Create a copy of SurahContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahContentCopyWith<SurahContent> get copyWith => _$SurahContentCopyWithImpl<SurahContent>(this as SurahContent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahContent&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other.ayahs, ayahs));
}


@override
int get hashCode => Object.hash(runtimeType,surah,language,const DeepCollectionEquality().hash(ayahs));

@override
String toString() {
  return 'SurahContent(surah: $surah, language: $language, ayahs: $ayahs)';
}


}

/// @nodoc
abstract mixin class $SurahContentCopyWith<$Res>  {
  factory $SurahContentCopyWith(SurahContent value, $Res Function(SurahContent) _then) = _$SurahContentCopyWithImpl;
@useResult
$Res call({
 Surah surah, QuranLanguage language, List<Ayah> ayahs
});


$SurahCopyWith<$Res> get surah;

}
/// @nodoc
class _$SurahContentCopyWithImpl<$Res>
    implements $SurahContentCopyWith<$Res> {
  _$SurahContentCopyWithImpl(this._self, this._then);

  final SurahContent _self;
  final $Res Function(SurahContent) _then;

/// Create a copy of SurahContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surah = null,Object? language = null,Object? ayahs = null,}) {
  return _then(SurahContent(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as Surah,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as QuranLanguage,ayahs: null == ayahs ? _self.ayahs : ayahs // ignore: cast_nullable_to_non_nullable
as List<Ayah>,
  ));
}
/// Create a copy of SurahContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahCopyWith<$Res> get surah {
  
  return $SurahCopyWith<$Res>(_self.surah, (value) {
    return _then(_self.copyWith(surah: value));
  });
}
}


/// Adds pattern-matching-related methods to [SurahContent].
extension SurahContentPatterns on SurahContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahContent value)  $default,){
final _that = this;
switch (_that) {
case _SurahContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahContent value)?  $default,){
final _that = this;
switch (_that) {
case _SurahContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Surah surah,  QuranLanguage language,  List<Ayah> ayahs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahContent() when $default != null:
return $default(_that.surah,_that.language,_that.ayahs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Surah surah,  QuranLanguage language,  List<Ayah> ayahs)  $default,) {final _that = this;
switch (_that) {
case _SurahContent():
return $default(_that.surah,_that.language,_that.ayahs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Surah surah,  QuranLanguage language,  List<Ayah> ayahs)?  $default,) {final _that = this;
switch (_that) {
case _SurahContent() when $default != null:
return $default(_that.surah,_that.language,_that.ayahs);case _:
  return null;

}
}

}

/// @nodoc


class _SurahContent implements SurahContent {
  const _SurahContent({required this.surah, required this.language, required  List<Ayah> ayahs}): _ayahs = ayahs;
  

@override final  Surah surah;
@override final  QuranLanguage language;
 final  List<Ayah> _ayahs;
@override List<Ayah> get ayahs {
  if (_ayahs is EqualUnmodifiableListView) return _ayahs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ayahs);
}


/// Create a copy of SurahContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahContentCopyWith<_SurahContent> get copyWith => __$SurahContentCopyWithImpl<_SurahContent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahContent&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other._ayahs, _ayahs));
}


@override
int get hashCode => Object.hash(runtimeType,surah,language,const DeepCollectionEquality().hash(_ayahs));

@override
String toString() {
  return 'SurahContent(surah: $surah, language: $language, ayahs: $ayahs)';
}


}

/// @nodoc
abstract mixin class _$SurahContentCopyWith<$Res> implements $SurahContentCopyWith<$Res> {
  factory _$SurahContentCopyWith(_SurahContent value, $Res Function(_SurahContent) _then) = __$SurahContentCopyWithImpl;
@override @useResult
$Res call({
 Surah surah, QuranLanguage language, List<Ayah> ayahs
});


@override $SurahCopyWith<$Res> get surah;

}
/// @nodoc
class __$SurahContentCopyWithImpl<$Res>
    implements _$SurahContentCopyWith<$Res> {
  __$SurahContentCopyWithImpl(this._self, this._then);

  final _SurahContent _self;
  final $Res Function(_SurahContent) _then;

/// Create a copy of SurahContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surah = null,Object? language = null,Object? ayahs = null,}) {
  return _then(_SurahContent(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as Surah,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as QuranLanguage,ayahs: null == ayahs ? _self._ayahs : ayahs // ignore: cast_nullable_to_non_nullable
as List<Ayah>,
  ));
}

/// Create a copy of SurahContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahCopyWith<$Res> get surah {
  
  return $SurahCopyWith<$Res>(_self.surah, (value) {
    return _then(_self.copyWith(surah: value));
  });
}
}

// dart format on
