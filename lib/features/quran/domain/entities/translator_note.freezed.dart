// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translator_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TranslatorNote {

 int get marker; String get text;
/// Create a copy of TranslatorNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslatorNoteCopyWith<TranslatorNote> get copyWith => _$TranslatorNoteCopyWithImpl<TranslatorNote>(this as TranslatorNote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslatorNote&&(identical(other.marker, marker) || other.marker == marker)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,marker,text);

@override
String toString() {
  return 'TranslatorNote(marker: $marker, text: $text)';
}


}

/// @nodoc
abstract mixin class $TranslatorNoteCopyWith<$Res>  {
  factory $TranslatorNoteCopyWith(TranslatorNote value, $Res Function(TranslatorNote) _then) = _$TranslatorNoteCopyWithImpl;
@useResult
$Res call({
 int marker, String text
});




}
/// @nodoc
class _$TranslatorNoteCopyWithImpl<$Res>
    implements $TranslatorNoteCopyWith<$Res> {
  _$TranslatorNoteCopyWithImpl(this._self, this._then);

  final TranslatorNote _self;
  final $Res Function(TranslatorNote) _then;

/// Create a copy of TranslatorNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? marker = null,Object? text = null,}) {
  return _then(TranslatorNote(
marker: null == marker ? _self.marker : marker // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TranslatorNote].
extension TranslatorNotePatterns on TranslatorNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslatorNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslatorNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslatorNote value)  $default,){
final _that = this;
switch (_that) {
case _TranslatorNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslatorNote value)?  $default,){
final _that = this;
switch (_that) {
case _TranslatorNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int marker,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslatorNote() when $default != null:
return $default(_that.marker,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int marker,  String text)  $default,) {final _that = this;
switch (_that) {
case _TranslatorNote():
return $default(_that.marker,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int marker,  String text)?  $default,) {final _that = this;
switch (_that) {
case _TranslatorNote() when $default != null:
return $default(_that.marker,_that.text);case _:
  return null;

}
}

}

/// @nodoc


class _TranslatorNote implements TranslatorNote {
  const _TranslatorNote({required this.marker, required this.text});
  

@override final  int marker;
@override final  String text;

/// Create a copy of TranslatorNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslatorNoteCopyWith<_TranslatorNote> get copyWith => __$TranslatorNoteCopyWithImpl<_TranslatorNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslatorNote&&(identical(other.marker, marker) || other.marker == marker)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,marker,text);

@override
String toString() {
  return 'TranslatorNote(marker: $marker, text: $text)';
}


}

/// @nodoc
abstract mixin class _$TranslatorNoteCopyWith<$Res> implements $TranslatorNoteCopyWith<$Res> {
  factory _$TranslatorNoteCopyWith(_TranslatorNote value, $Res Function(_TranslatorNote) _then) = __$TranslatorNoteCopyWithImpl;
@override @useResult
$Res call({
 int marker, String text
});




}
/// @nodoc
class __$TranslatorNoteCopyWithImpl<$Res>
    implements _$TranslatorNoteCopyWith<$Res> {
  __$TranslatorNoteCopyWithImpl(this._self, this._then);

  final _TranslatorNote _self;
  final $Res Function(_TranslatorNote) _then;

/// Create a copy of TranslatorNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? marker = null,Object? text = null,}) {
  return _then(_TranslatorNote(
marker: null == marker ? _self.marker : marker // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
