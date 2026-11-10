// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Surah {

 int get number; String get englishName; String get meaning;/// Arabic name as delivered by the source, including the leading
/// "سُورَةُ" word. Use [displayArabicName] for UI.
 String get arabicName; int get ayahCount; RevelationPlace get revelation;
/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahCopyWith<Surah> get copyWith => _$SurahCopyWithImpl<Surah>(this as Surah, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Surah&&(identical(other.number, number) || other.number == number)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.ayahCount, ayahCount) || other.ayahCount == ayahCount)&&(identical(other.revelation, revelation) || other.revelation == revelation));
}


@override
int get hashCode => Object.hash(runtimeType,number,englishName,meaning,arabicName,ayahCount,revelation);

@override
String toString() {
  return 'Surah(number: $number, englishName: $englishName, meaning: $meaning, arabicName: $arabicName, ayahCount: $ayahCount, revelation: $revelation)';
}


}

/// @nodoc
abstract mixin class $SurahCopyWith<$Res>  {
  factory $SurahCopyWith(Surah value, $Res Function(Surah) _then) = _$SurahCopyWithImpl;
@useResult
$Res call({
 int number, String englishName, String meaning, String arabicName, int ayahCount, RevelationPlace revelation
});




}
/// @nodoc
class _$SurahCopyWithImpl<$Res>
    implements $SurahCopyWith<$Res> {
  _$SurahCopyWithImpl(this._self, this._then);

  final Surah _self;
  final $Res Function(Surah) _then;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? englishName = null,Object? meaning = null,Object? arabicName = null,Object? ayahCount = null,Object? revelation = null,}) {
  return _then(Surah(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,ayahCount: null == ayahCount ? _self.ayahCount : ayahCount // ignore: cast_nullable_to_non_nullable
as int,revelation: null == revelation ? _self.revelation : revelation // ignore: cast_nullable_to_non_nullable
as RevelationPlace,
  ));
}

}


/// Adds pattern-matching-related methods to [Surah].
extension SurahPatterns on Surah {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Surah value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Surah() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Surah value)  $default,){
final _that = this;
switch (_that) {
case _Surah():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Surah value)?  $default,){
final _that = this;
switch (_that) {
case _Surah() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String englishName,  String meaning,  String arabicName,  int ayahCount,  RevelationPlace revelation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Surah() when $default != null:
return $default(_that.number,_that.englishName,_that.meaning,_that.arabicName,_that.ayahCount,_that.revelation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String englishName,  String meaning,  String arabicName,  int ayahCount,  RevelationPlace revelation)  $default,) {final _that = this;
switch (_that) {
case _Surah():
return $default(_that.number,_that.englishName,_that.meaning,_that.arabicName,_that.ayahCount,_that.revelation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String englishName,  String meaning,  String arabicName,  int ayahCount,  RevelationPlace revelation)?  $default,) {final _that = this;
switch (_that) {
case _Surah() when $default != null:
return $default(_that.number,_that.englishName,_that.meaning,_that.arabicName,_that.ayahCount,_that.revelation);case _:
  return null;

}
}

}

/// @nodoc


class _Surah extends Surah {
  const _Surah({required this.number, required this.englishName, required this.meaning, required this.arabicName, required this.ayahCount, required this.revelation}): super._();
  

@override final  int number;
@override final  String englishName;
@override final  String meaning;
/// Arabic name as delivered by the source, including the leading
/// "سُورَةُ" word. Use [displayArabicName] for UI.
@override final  String arabicName;
@override final  int ayahCount;
@override final  RevelationPlace revelation;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahCopyWith<_Surah> get copyWith => __$SurahCopyWithImpl<_Surah>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Surah&&(identical(other.number, number) || other.number == number)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.meaning, meaning) || other.meaning == meaning)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.ayahCount, ayahCount) || other.ayahCount == ayahCount)&&(identical(other.revelation, revelation) || other.revelation == revelation));
}


@override
int get hashCode => Object.hash(runtimeType,number,englishName,meaning,arabicName,ayahCount,revelation);

@override
String toString() {
  return 'Surah(number: $number, englishName: $englishName, meaning: $meaning, arabicName: $arabicName, ayahCount: $ayahCount, revelation: $revelation)';
}


}

/// @nodoc
abstract mixin class _$SurahCopyWith<$Res> implements $SurahCopyWith<$Res> {
  factory _$SurahCopyWith(_Surah value, $Res Function(_Surah) _then) = __$SurahCopyWithImpl;
@override @useResult
$Res call({
 int number, String englishName, String meaning, String arabicName, int ayahCount, RevelationPlace revelation
});




}
/// @nodoc
class __$SurahCopyWithImpl<$Res>
    implements _$SurahCopyWith<$Res> {
  __$SurahCopyWithImpl(this._self, this._then);

  final _Surah _self;
  final $Res Function(_Surah) _then;

/// Create a copy of Surah
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? englishName = null,Object? meaning = null,Object? arabicName = null,Object? ayahCount = null,Object? revelation = null,}) {
  return _then(_Surah(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,meaning: null == meaning ? _self.meaning : meaning // ignore: cast_nullable_to_non_nullable
as String,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,ayahCount: null == ayahCount ? _self.ayahCount : ayahCount // ignore: cast_nullable_to_non_nullable
as int,revelation: null == revelation ? _self.revelation : revelation // ignore: cast_nullable_to_non_nullable
as RevelationPlace,
  ));
}


}

// dart format on
