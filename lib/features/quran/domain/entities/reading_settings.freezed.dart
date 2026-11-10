// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReadingSettings {

 QuranLanguage get language; ArabicTextSize get arabicSize; AyahRef? get lastRead;
/// Create a copy of ReadingSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingSettingsCopyWith<ReadingSettings> get copyWith => _$ReadingSettingsCopyWithImpl<ReadingSettings>(this as ReadingSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingSettings&&(identical(other.language, language) || other.language == language)&&(identical(other.arabicSize, arabicSize) || other.arabicSize == arabicSize)&&(identical(other.lastRead, lastRead) || other.lastRead == lastRead));
}


@override
int get hashCode => Object.hash(runtimeType,language,arabicSize,lastRead);

@override
String toString() {
  return 'ReadingSettings(language: $language, arabicSize: $arabicSize, lastRead: $lastRead)';
}


}

/// @nodoc
abstract mixin class $ReadingSettingsCopyWith<$Res>  {
  factory $ReadingSettingsCopyWith(ReadingSettings value, $Res Function(ReadingSettings) _then) = _$ReadingSettingsCopyWithImpl;
@useResult
$Res call({
 QuranLanguage language, ArabicTextSize arabicSize, AyahRef? lastRead
});


$AyahRefCopyWith<$Res>? get lastRead;

}
/// @nodoc
class _$ReadingSettingsCopyWithImpl<$Res>
    implements $ReadingSettingsCopyWith<$Res> {
  _$ReadingSettingsCopyWithImpl(this._self, this._then);

  final ReadingSettings _self;
  final $Res Function(ReadingSettings) _then;

/// Create a copy of ReadingSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? arabicSize = null,Object? lastRead = freezed,}) {
  return _then(ReadingSettings(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as QuranLanguage,arabicSize: null == arabicSize ? _self.arabicSize : arabicSize // ignore: cast_nullable_to_non_nullable
as ArabicTextSize,lastRead: freezed == lastRead ? _self.lastRead : lastRead // ignore: cast_nullable_to_non_nullable
as AyahRef?,
  ));
}
/// Create a copy of ReadingSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahRefCopyWith<$Res>? get lastRead {
    if (_self.lastRead == null) {
    return null;
  }

  return $AyahRefCopyWith<$Res>(_self.lastRead!, (value) {
    return _then(_self.copyWith(lastRead: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReadingSettings].
extension ReadingSettingsPatterns on ReadingSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingSettings value)  $default,){
final _that = this;
switch (_that) {
case _ReadingSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuranLanguage language,  ArabicTextSize arabicSize,  AyahRef? lastRead)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingSettings() when $default != null:
return $default(_that.language,_that.arabicSize,_that.lastRead);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuranLanguage language,  ArabicTextSize arabicSize,  AyahRef? lastRead)  $default,) {final _that = this;
switch (_that) {
case _ReadingSettings():
return $default(_that.language,_that.arabicSize,_that.lastRead);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuranLanguage language,  ArabicTextSize arabicSize,  AyahRef? lastRead)?  $default,) {final _that = this;
switch (_that) {
case _ReadingSettings() when $default != null:
return $default(_that.language,_that.arabicSize,_that.lastRead);case _:
  return null;

}
}

}

/// @nodoc


class _ReadingSettings implements ReadingSettings {
  const _ReadingSettings({required this.language, required this.arabicSize, this.lastRead});
  

@override final  QuranLanguage language;
@override final  ArabicTextSize arabicSize;
@override final  AyahRef? lastRead;

/// Create a copy of ReadingSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingSettingsCopyWith<_ReadingSettings> get copyWith => __$ReadingSettingsCopyWithImpl<_ReadingSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingSettings&&(identical(other.language, language) || other.language == language)&&(identical(other.arabicSize, arabicSize) || other.arabicSize == arabicSize)&&(identical(other.lastRead, lastRead) || other.lastRead == lastRead));
}


@override
int get hashCode => Object.hash(runtimeType,language,arabicSize,lastRead);

@override
String toString() {
  return 'ReadingSettings(language: $language, arabicSize: $arabicSize, lastRead: $lastRead)';
}


}

/// @nodoc
abstract mixin class _$ReadingSettingsCopyWith<$Res> implements $ReadingSettingsCopyWith<$Res> {
  factory _$ReadingSettingsCopyWith(_ReadingSettings value, $Res Function(_ReadingSettings) _then) = __$ReadingSettingsCopyWithImpl;
@override @useResult
$Res call({
 QuranLanguage language, ArabicTextSize arabicSize, AyahRef? lastRead
});


@override $AyahRefCopyWith<$Res>? get lastRead;

}
/// @nodoc
class __$ReadingSettingsCopyWithImpl<$Res>
    implements _$ReadingSettingsCopyWith<$Res> {
  __$ReadingSettingsCopyWithImpl(this._self, this._then);

  final _ReadingSettings _self;
  final $Res Function(_ReadingSettings) _then;

/// Create a copy of ReadingSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? arabicSize = null,Object? lastRead = freezed,}) {
  return _then(_ReadingSettings(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as QuranLanguage,arabicSize: null == arabicSize ? _self.arabicSize : arabicSize // ignore: cast_nullable_to_non_nullable
as ArabicTextSize,lastRead: freezed == lastRead ? _self.lastRead : lastRead // ignore: cast_nullable_to_non_nullable
as AyahRef?,
  ));
}

/// Create a copy of ReadingSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahRefCopyWith<$Res>? get lastRead {
    if (_self.lastRead == null) {
    return null;
  }

  return $AyahRefCopyWith<$Res>(_self.lastRead!, (value) {
    return _then(_self.copyWith(lastRead: value));
  });
}
}

// dart format on
