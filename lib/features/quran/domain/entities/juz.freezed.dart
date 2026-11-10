// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'juz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Juz {

 int get number; AyahRef get start;
/// Create a copy of Juz
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JuzCopyWith<Juz> get copyWith => _$JuzCopyWithImpl<Juz>(this as Juz, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Juz&&(identical(other.number, number) || other.number == number)&&(identical(other.start, start) || other.start == start));
}


@override
int get hashCode => Object.hash(runtimeType,number,start);

@override
String toString() {
  return 'Juz(number: $number, start: $start)';
}


}

/// @nodoc
abstract mixin class $JuzCopyWith<$Res>  {
  factory $JuzCopyWith(Juz value, $Res Function(Juz) _then) = _$JuzCopyWithImpl;
@useResult
$Res call({
 int number, AyahRef start
});


$AyahRefCopyWith<$Res> get start;

}
/// @nodoc
class _$JuzCopyWithImpl<$Res>
    implements $JuzCopyWith<$Res> {
  _$JuzCopyWithImpl(this._self, this._then);

  final Juz _self;
  final $Res Function(Juz) _then;

/// Create a copy of Juz
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? start = null,}) {
  return _then(Juz(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as AyahRef,
  ));
}
/// Create a copy of Juz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahRefCopyWith<$Res> get start {
  
  return $AyahRefCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}
}


/// Adds pattern-matching-related methods to [Juz].
extension JuzPatterns on Juz {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Juz value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Juz() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Juz value)  $default,){
final _that = this;
switch (_that) {
case _Juz():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Juz value)?  $default,){
final _that = this;
switch (_that) {
case _Juz() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  AyahRef start)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Juz() when $default != null:
return $default(_that.number,_that.start);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  AyahRef start)  $default,) {final _that = this;
switch (_that) {
case _Juz():
return $default(_that.number,_that.start);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  AyahRef start)?  $default,) {final _that = this;
switch (_that) {
case _Juz() when $default != null:
return $default(_that.number,_that.start);case _:
  return null;

}
}

}

/// @nodoc


class _Juz implements Juz {
  const _Juz({required this.number, required this.start});
  

@override final  int number;
@override final  AyahRef start;

/// Create a copy of Juz
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JuzCopyWith<_Juz> get copyWith => __$JuzCopyWithImpl<_Juz>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Juz&&(identical(other.number, number) || other.number == number)&&(identical(other.start, start) || other.start == start));
}


@override
int get hashCode => Object.hash(runtimeType,number,start);

@override
String toString() {
  return 'Juz(number: $number, start: $start)';
}


}

/// @nodoc
abstract mixin class _$JuzCopyWith<$Res> implements $JuzCopyWith<$Res> {
  factory _$JuzCopyWith(_Juz value, $Res Function(_Juz) _then) = __$JuzCopyWithImpl;
@override @useResult
$Res call({
 int number, AyahRef start
});


@override $AyahRefCopyWith<$Res> get start;

}
/// @nodoc
class __$JuzCopyWithImpl<$Res>
    implements _$JuzCopyWith<$Res> {
  __$JuzCopyWithImpl(this._self, this._then);

  final _Juz _self;
  final $Res Function(_Juz) _then;

/// Create a copy of Juz
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? start = null,}) {
  return _then(_Juz(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as AyahRef,
  ));
}

/// Create a copy of Juz
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahRefCopyWith<$Res> get start {
  
  return $AyahRefCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}
}

/// @nodoc
mixin _$JuzSection {

 int get surah; int get fromAyah; int get toAyah;
/// Create a copy of JuzSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JuzSectionCopyWith<JuzSection> get copyWith => _$JuzSectionCopyWithImpl<JuzSection>(this as JuzSection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JuzSection&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.fromAyah, fromAyah) || other.fromAyah == fromAyah)&&(identical(other.toAyah, toAyah) || other.toAyah == toAyah));
}


@override
int get hashCode => Object.hash(runtimeType,surah,fromAyah,toAyah);

@override
String toString() {
  return 'JuzSection(surah: $surah, fromAyah: $fromAyah, toAyah: $toAyah)';
}


}

/// @nodoc
abstract mixin class $JuzSectionCopyWith<$Res>  {
  factory $JuzSectionCopyWith(JuzSection value, $Res Function(JuzSection) _then) = _$JuzSectionCopyWithImpl;
@useResult
$Res call({
 int surah, int fromAyah, int toAyah
});




}
/// @nodoc
class _$JuzSectionCopyWithImpl<$Res>
    implements $JuzSectionCopyWith<$Res> {
  _$JuzSectionCopyWithImpl(this._self, this._then);

  final JuzSection _self;
  final $Res Function(JuzSection) _then;

/// Create a copy of JuzSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surah = null,Object? fromAyah = null,Object? toAyah = null,}) {
  return _then(JuzSection(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as int,fromAyah: null == fromAyah ? _self.fromAyah : fromAyah // ignore: cast_nullable_to_non_nullable
as int,toAyah: null == toAyah ? _self.toAyah : toAyah // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [JuzSection].
extension JuzSectionPatterns on JuzSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JuzSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JuzSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JuzSection value)  $default,){
final _that = this;
switch (_that) {
case _JuzSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JuzSection value)?  $default,){
final _that = this;
switch (_that) {
case _JuzSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surah,  int fromAyah,  int toAyah)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JuzSection() when $default != null:
return $default(_that.surah,_that.fromAyah,_that.toAyah);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surah,  int fromAyah,  int toAyah)  $default,) {final _that = this;
switch (_that) {
case _JuzSection():
return $default(_that.surah,_that.fromAyah,_that.toAyah);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surah,  int fromAyah,  int toAyah)?  $default,) {final _that = this;
switch (_that) {
case _JuzSection() when $default != null:
return $default(_that.surah,_that.fromAyah,_that.toAyah);case _:
  return null;

}
}

}

/// @nodoc


class _JuzSection implements JuzSection {
  const _JuzSection({required this.surah, required this.fromAyah, required this.toAyah});
  

@override final  int surah;
@override final  int fromAyah;
@override final  int toAyah;

/// Create a copy of JuzSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JuzSectionCopyWith<_JuzSection> get copyWith => __$JuzSectionCopyWithImpl<_JuzSection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JuzSection&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.fromAyah, fromAyah) || other.fromAyah == fromAyah)&&(identical(other.toAyah, toAyah) || other.toAyah == toAyah));
}


@override
int get hashCode => Object.hash(runtimeType,surah,fromAyah,toAyah);

@override
String toString() {
  return 'JuzSection(surah: $surah, fromAyah: $fromAyah, toAyah: $toAyah)';
}


}

/// @nodoc
abstract mixin class _$JuzSectionCopyWith<$Res> implements $JuzSectionCopyWith<$Res> {
  factory _$JuzSectionCopyWith(_JuzSection value, $Res Function(_JuzSection) _then) = __$JuzSectionCopyWithImpl;
@override @useResult
$Res call({
 int surah, int fromAyah, int toAyah
});




}
/// @nodoc
class __$JuzSectionCopyWithImpl<$Res>
    implements _$JuzSectionCopyWith<$Res> {
  __$JuzSectionCopyWithImpl(this._self, this._then);

  final _JuzSection _self;
  final $Res Function(_JuzSection) _then;

/// Create a copy of JuzSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surah = null,Object? fromAyah = null,Object? toAyah = null,}) {
  return _then(_JuzSection(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as int,fromAyah: null == fromAyah ? _self.fromAyah : fromAyah // ignore: cast_nullable_to_non_nullable
as int,toAyah: null == toAyah ? _self.toAyah : toAyah // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
