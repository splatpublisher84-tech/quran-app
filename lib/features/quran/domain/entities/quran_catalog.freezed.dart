// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuranCatalog {

 List<Surah> get surahs; List<Juz> get juzs;
/// Create a copy of QuranCatalog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranCatalogCopyWith<QuranCatalog> get copyWith => _$QuranCatalogCopyWithImpl<QuranCatalog>(this as QuranCatalog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranCatalog&&const DeepCollectionEquality().equals(other.surahs, surahs)&&const DeepCollectionEquality().equals(other.juzs, juzs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(surahs),const DeepCollectionEquality().hash(juzs));

@override
String toString() {
  return 'QuranCatalog(surahs: $surahs, juzs: $juzs)';
}


}

/// @nodoc
abstract mixin class $QuranCatalogCopyWith<$Res>  {
  factory $QuranCatalogCopyWith(QuranCatalog value, $Res Function(QuranCatalog) _then) = _$QuranCatalogCopyWithImpl;
@useResult
$Res call({
 List<Surah> surahs, List<Juz> juzs
});




}
/// @nodoc
class _$QuranCatalogCopyWithImpl<$Res>
    implements $QuranCatalogCopyWith<$Res> {
  _$QuranCatalogCopyWithImpl(this._self, this._then);

  final QuranCatalog _self;
  final $Res Function(QuranCatalog) _then;

/// Create a copy of QuranCatalog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahs = null,Object? juzs = null,}) {
  return _then(QuranCatalog(
surahs: null == surahs ? _self.surahs : surahs // ignore: cast_nullable_to_non_nullable
as List<Surah>,juzs: null == juzs ? _self.juzs : juzs // ignore: cast_nullable_to_non_nullable
as List<Juz>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranCatalog].
extension QuranCatalogPatterns on QuranCatalog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranCatalog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranCatalog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranCatalog value)  $default,){
final _that = this;
switch (_that) {
case _QuranCatalog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranCatalog value)?  $default,){
final _that = this;
switch (_that) {
case _QuranCatalog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Surah> surahs,  List<Juz> juzs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranCatalog() when $default != null:
return $default(_that.surahs,_that.juzs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Surah> surahs,  List<Juz> juzs)  $default,) {final _that = this;
switch (_that) {
case _QuranCatalog():
return $default(_that.surahs,_that.juzs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Surah> surahs,  List<Juz> juzs)?  $default,) {final _that = this;
switch (_that) {
case _QuranCatalog() when $default != null:
return $default(_that.surahs,_that.juzs);case _:
  return null;

}
}

}

/// @nodoc


class _QuranCatalog implements QuranCatalog {
  const _QuranCatalog({required  List<Surah> surahs, required  List<Juz> juzs}): _surahs = surahs,_juzs = juzs;
  

 final  List<Surah> _surahs;
@override List<Surah> get surahs {
  if (_surahs is EqualUnmodifiableListView) return _surahs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surahs);
}

 final  List<Juz> _juzs;
@override List<Juz> get juzs {
  if (_juzs is EqualUnmodifiableListView) return _juzs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_juzs);
}


/// Create a copy of QuranCatalog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranCatalogCopyWith<_QuranCatalog> get copyWith => __$QuranCatalogCopyWithImpl<_QuranCatalog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranCatalog&&const DeepCollectionEquality().equals(other._surahs, _surahs)&&const DeepCollectionEquality().equals(other._juzs, _juzs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_surahs),const DeepCollectionEquality().hash(_juzs));

@override
String toString() {
  return 'QuranCatalog(surahs: $surahs, juzs: $juzs)';
}


}

/// @nodoc
abstract mixin class _$QuranCatalogCopyWith<$Res> implements $QuranCatalogCopyWith<$Res> {
  factory _$QuranCatalogCopyWith(_QuranCatalog value, $Res Function(_QuranCatalog) _then) = __$QuranCatalogCopyWithImpl;
@override @useResult
$Res call({
 List<Surah> surahs, List<Juz> juzs
});




}
/// @nodoc
class __$QuranCatalogCopyWithImpl<$Res>
    implements _$QuranCatalogCopyWith<$Res> {
  __$QuranCatalogCopyWithImpl(this._self, this._then);

  final _QuranCatalog _self;
  final $Res Function(_QuranCatalog) _then;

/// Create a copy of QuranCatalog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahs = null,Object? juzs = null,}) {
  return _then(_QuranCatalog(
surahs: null == surahs ? _self._surahs : surahs // ignore: cast_nullable_to_non_nullable
as List<Surah>,juzs: null == juzs ? _self._juzs : juzs // ignore: cast_nullable_to_non_nullable
as List<Juz>,
  ));
}


}

// dart format on
