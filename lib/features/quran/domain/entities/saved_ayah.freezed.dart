// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_ayah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedAyahRecord {

 AyahRef get ref; DateTime get savedAt;
/// Create a copy of SavedAyahRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedAyahRecordCopyWith<SavedAyahRecord> get copyWith => _$SavedAyahRecordCopyWithImpl<SavedAyahRecord>(this as SavedAyahRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedAyahRecord&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt));
}


@override
int get hashCode => Object.hash(runtimeType,ref,savedAt);

@override
String toString() {
  return 'SavedAyahRecord(ref: $ref, savedAt: $savedAt)';
}


}

/// @nodoc
abstract mixin class $SavedAyahRecordCopyWith<$Res>  {
  factory $SavedAyahRecordCopyWith(SavedAyahRecord value, $Res Function(SavedAyahRecord) _then) = _$SavedAyahRecordCopyWithImpl;
@useResult
$Res call({
 AyahRef ref, DateTime savedAt
});


$AyahRefCopyWith<$Res> get ref;

}
/// @nodoc
class _$SavedAyahRecordCopyWithImpl<$Res>
    implements $SavedAyahRecordCopyWith<$Res> {
  _$SavedAyahRecordCopyWithImpl(this._self, this._then);

  final SavedAyahRecord _self;
  final $Res Function(SavedAyahRecord) _then;

/// Create a copy of SavedAyahRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ref = null,Object? savedAt = null,}) {
  return _then(SavedAyahRecord(
ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as AyahRef,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of SavedAyahRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahRefCopyWith<$Res> get ref {
  
  return $AyahRefCopyWith<$Res>(_self.ref, (value) {
    return _then(_self.copyWith(ref: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedAyahRecord].
extension SavedAyahRecordPatterns on SavedAyahRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedAyahRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedAyahRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedAyahRecord value)  $default,){
final _that = this;
switch (_that) {
case _SavedAyahRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedAyahRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SavedAyahRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AyahRef ref,  DateTime savedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedAyahRecord() when $default != null:
return $default(_that.ref,_that.savedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AyahRef ref,  DateTime savedAt)  $default,) {final _that = this;
switch (_that) {
case _SavedAyahRecord():
return $default(_that.ref,_that.savedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AyahRef ref,  DateTime savedAt)?  $default,) {final _that = this;
switch (_that) {
case _SavedAyahRecord() when $default != null:
return $default(_that.ref,_that.savedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SavedAyahRecord implements SavedAyahRecord {
  const _SavedAyahRecord({required this.ref, required this.savedAt});
  

@override final  AyahRef ref;
@override final  DateTime savedAt;

/// Create a copy of SavedAyahRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedAyahRecordCopyWith<_SavedAyahRecord> get copyWith => __$SavedAyahRecordCopyWithImpl<_SavedAyahRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedAyahRecord&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt));
}


@override
int get hashCode => Object.hash(runtimeType,ref,savedAt);

@override
String toString() {
  return 'SavedAyahRecord(ref: $ref, savedAt: $savedAt)';
}


}

/// @nodoc
abstract mixin class _$SavedAyahRecordCopyWith<$Res> implements $SavedAyahRecordCopyWith<$Res> {
  factory _$SavedAyahRecordCopyWith(_SavedAyahRecord value, $Res Function(_SavedAyahRecord) _then) = __$SavedAyahRecordCopyWithImpl;
@override @useResult
$Res call({
 AyahRef ref, DateTime savedAt
});


@override $AyahRefCopyWith<$Res> get ref;

}
/// @nodoc
class __$SavedAyahRecordCopyWithImpl<$Res>
    implements _$SavedAyahRecordCopyWith<$Res> {
  __$SavedAyahRecordCopyWithImpl(this._self, this._then);

  final _SavedAyahRecord _self;
  final $Res Function(_SavedAyahRecord) _then;

/// Create a copy of SavedAyahRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ref = null,Object? savedAt = null,}) {
  return _then(_SavedAyahRecord(
ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as AyahRef,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of SavedAyahRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahRefCopyWith<$Res> get ref {
  
  return $AyahRefCopyWith<$Res>(_self.ref, (value) {
    return _then(_self.copyWith(ref: value));
  });
}
}

/// @nodoc
mixin _$SavedAyah {

 AyahRef get ref; DateTime get savedAt; String get arabic; String get translation;
/// Create a copy of SavedAyah
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedAyahCopyWith<SavedAyah> get copyWith => _$SavedAyahCopyWithImpl<SavedAyah>(this as SavedAyah, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedAyah&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.arabic, arabic) || other.arabic == arabic)&&(identical(other.translation, translation) || other.translation == translation));
}


@override
int get hashCode => Object.hash(runtimeType,ref,savedAt,arabic,translation);

@override
String toString() {
  return 'SavedAyah(ref: $ref, savedAt: $savedAt, arabic: $arabic, translation: $translation)';
}


}

/// @nodoc
abstract mixin class $SavedAyahCopyWith<$Res>  {
  factory $SavedAyahCopyWith(SavedAyah value, $Res Function(SavedAyah) _then) = _$SavedAyahCopyWithImpl;
@useResult
$Res call({
 AyahRef ref, DateTime savedAt, String arabic, String translation
});


$AyahRefCopyWith<$Res> get ref;

}
/// @nodoc
class _$SavedAyahCopyWithImpl<$Res>
    implements $SavedAyahCopyWith<$Res> {
  _$SavedAyahCopyWithImpl(this._self, this._then);

  final SavedAyah _self;
  final $Res Function(SavedAyah) _then;

/// Create a copy of SavedAyah
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ref = null,Object? savedAt = null,Object? arabic = null,Object? translation = null,}) {
  return _then(SavedAyah(
ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as AyahRef,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SavedAyah
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahRefCopyWith<$Res> get ref {
  
  return $AyahRefCopyWith<$Res>(_self.ref, (value) {
    return _then(_self.copyWith(ref: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedAyah].
extension SavedAyahPatterns on SavedAyah {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedAyah value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedAyah() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedAyah value)  $default,){
final _that = this;
switch (_that) {
case _SavedAyah():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedAyah value)?  $default,){
final _that = this;
switch (_that) {
case _SavedAyah() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AyahRef ref,  DateTime savedAt,  String arabic,  String translation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedAyah() when $default != null:
return $default(_that.ref,_that.savedAt,_that.arabic,_that.translation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AyahRef ref,  DateTime savedAt,  String arabic,  String translation)  $default,) {final _that = this;
switch (_that) {
case _SavedAyah():
return $default(_that.ref,_that.savedAt,_that.arabic,_that.translation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AyahRef ref,  DateTime savedAt,  String arabic,  String translation)?  $default,) {final _that = this;
switch (_that) {
case _SavedAyah() when $default != null:
return $default(_that.ref,_that.savedAt,_that.arabic,_that.translation);case _:
  return null;

}
}

}

/// @nodoc


class _SavedAyah implements SavedAyah {
  const _SavedAyah({required this.ref, required this.savedAt, required this.arabic, required this.translation});
  

@override final  AyahRef ref;
@override final  DateTime savedAt;
@override final  String arabic;
@override final  String translation;

/// Create a copy of SavedAyah
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedAyahCopyWith<_SavedAyah> get copyWith => __$SavedAyahCopyWithImpl<_SavedAyah>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedAyah&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.arabic, arabic) || other.arabic == arabic)&&(identical(other.translation, translation) || other.translation == translation));
}


@override
int get hashCode => Object.hash(runtimeType,ref,savedAt,arabic,translation);

@override
String toString() {
  return 'SavedAyah(ref: $ref, savedAt: $savedAt, arabic: $arabic, translation: $translation)';
}


}

/// @nodoc
abstract mixin class _$SavedAyahCopyWith<$Res> implements $SavedAyahCopyWith<$Res> {
  factory _$SavedAyahCopyWith(_SavedAyah value, $Res Function(_SavedAyah) _then) = __$SavedAyahCopyWithImpl;
@override @useResult
$Res call({
 AyahRef ref, DateTime savedAt, String arabic, String translation
});


@override $AyahRefCopyWith<$Res> get ref;

}
/// @nodoc
class __$SavedAyahCopyWithImpl<$Res>
    implements _$SavedAyahCopyWith<$Res> {
  __$SavedAyahCopyWithImpl(this._self, this._then);

  final _SavedAyah _self;
  final $Res Function(_SavedAyah) _then;

/// Create a copy of SavedAyah
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ref = null,Object? savedAt = null,Object? arabic = null,Object? translation = null,}) {
  return _then(_SavedAyah(
ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as AyahRef,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,translation: null == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SavedAyah
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
