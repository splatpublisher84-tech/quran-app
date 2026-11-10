// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ayah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Ayah {

 AyahRef get ref; String get arabic; String get translation;/// Raw footnote block from the source. Parse it with `parseFootnotes`.
 String? get footnotes;
/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AyahCopyWith<Ayah> get copyWith => _$AyahCopyWithImpl<Ayah>(this as Ayah, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ayah&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.arabic, arabic) || other.arabic == arabic)&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.footnotes, footnotes) || other.footnotes == footnotes));
}


@override
int get hashCode => Object.hash(runtimeType,ref,arabic,translation,footnotes);

@override
String toString() {
  return 'Ayah(ref: $ref, arabic: $arabic, translation: $translation, footnotes: $footnotes)';
}


}

/// @nodoc
abstract mixin class $AyahCopyWith<$Res>  {
  factory $AyahCopyWith(Ayah value, $Res Function(Ayah) _then) = _$AyahCopyWithImpl;
@useResult
$Res call({
 AyahRef ref, String arabic, String translation, String? footnotes
});


$AyahRefCopyWith<$Res> get ref;

}
/// @nodoc
class _$AyahCopyWithImpl<$Res>
    implements $AyahCopyWith<$Res> {
  _$AyahCopyWithImpl(this._self, this._then);

  final Ayah _self;
  final $Res Function(Ayah) _then;

/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ref = null,Object? arabic = null,Object? translation = null,Object? footnotes = freezed,}) {
  return _then(Ayah(
ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as AyahRef,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,footnotes: freezed == footnotes ? _self.footnotes : footnotes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahRefCopyWith<$Res> get ref {
  
  return $AyahRefCopyWith<$Res>(_self.ref, (value) {
    return _then(_self.copyWith(ref: value));
  });
}
}


/// Adds pattern-matching-related methods to [Ayah].
extension AyahPatterns on Ayah {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ayah value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ayah() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ayah value)  $default,){
final _that = this;
switch (_that) {
case _Ayah():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ayah value)?  $default,){
final _that = this;
switch (_that) {
case _Ayah() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AyahRef ref,  String arabic,  String translation,  String? footnotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ayah() when $default != null:
return $default(_that.ref,_that.arabic,_that.translation,_that.footnotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AyahRef ref,  String arabic,  String translation,  String? footnotes)  $default,) {final _that = this;
switch (_that) {
case _Ayah():
return $default(_that.ref,_that.arabic,_that.translation,_that.footnotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AyahRef ref,  String arabic,  String translation,  String? footnotes)?  $default,) {final _that = this;
switch (_that) {
case _Ayah() when $default != null:
return $default(_that.ref,_that.arabic,_that.translation,_that.footnotes);case _:
  return null;

}
}

}

/// @nodoc


class _Ayah implements Ayah {
  const _Ayah({required this.ref, required this.arabic, required this.translation, this.footnotes});
  

@override final  AyahRef ref;
@override final  String arabic;
@override final  String translation;
/// Raw footnote block from the source. Parse it with `parseFootnotes`.
@override final  String? footnotes;

/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AyahCopyWith<_Ayah> get copyWith => __$AyahCopyWithImpl<_Ayah>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ayah&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.arabic, arabic) || other.arabic == arabic)&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.footnotes, footnotes) || other.footnotes == footnotes));
}


@override
int get hashCode => Object.hash(runtimeType,ref,arabic,translation,footnotes);

@override
String toString() {
  return 'Ayah(ref: $ref, arabic: $arabic, translation: $translation, footnotes: $footnotes)';
}


}

/// @nodoc
abstract mixin class _$AyahCopyWith<$Res> implements $AyahCopyWith<$Res> {
  factory _$AyahCopyWith(_Ayah value, $Res Function(_Ayah) _then) = __$AyahCopyWithImpl;
@override @useResult
$Res call({
 AyahRef ref, String arabic, String translation, String? footnotes
});


@override $AyahRefCopyWith<$Res> get ref;

}
/// @nodoc
class __$AyahCopyWithImpl<$Res>
    implements _$AyahCopyWith<$Res> {
  __$AyahCopyWithImpl(this._self, this._then);

  final _Ayah _self;
  final $Res Function(_Ayah) _then;

/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ref = null,Object? arabic = null,Object? translation = null,Object? footnotes = freezed,}) {
  return _then(_Ayah(
ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as AyahRef,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,footnotes: freezed == footnotes ? _self.footnotes : footnotes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Ayah
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahRefCopyWith<$Res> get ref {
  
  return $AyahRefCopyWith<$Res>(_self.ref, (value) {
    return _then(_self.copyWith(ref: value));
  });
}
}

// dart format on
