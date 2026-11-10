// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reader_blocks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReaderDocument {

 List<ReaderBlock> get blocks;
/// Create a copy of ReaderDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderDocumentCopyWith<ReaderDocument> get copyWith => _$ReaderDocumentCopyWithImpl<ReaderDocument>(this as ReaderDocument, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderDocument&&const DeepCollectionEquality().equals(other.blocks, blocks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(blocks));

@override
String toString() {
  return 'ReaderDocument(blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class $ReaderDocumentCopyWith<$Res>  {
  factory $ReaderDocumentCopyWith(ReaderDocument value, $Res Function(ReaderDocument) _then) = _$ReaderDocumentCopyWithImpl;
@useResult
$Res call({
 List<ReaderBlock> blocks
});




}
/// @nodoc
class _$ReaderDocumentCopyWithImpl<$Res>
    implements $ReaderDocumentCopyWith<$Res> {
  _$ReaderDocumentCopyWithImpl(this._self, this._then);

  final ReaderDocument _self;
  final $Res Function(ReaderDocument) _then;

/// Create a copy of ReaderDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? blocks = null,}) {
  return _then(ReaderDocument(
blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ReaderBlock>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReaderDocument].
extension ReaderDocumentPatterns on ReaderDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReaderDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReaderDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReaderDocument value)  $default,){
final _that = this;
switch (_that) {
case _ReaderDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReaderDocument value)?  $default,){
final _that = this;
switch (_that) {
case _ReaderDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReaderBlock> blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReaderDocument() when $default != null:
return $default(_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReaderBlock> blocks)  $default,) {final _that = this;
switch (_that) {
case _ReaderDocument():
return $default(_that.blocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReaderBlock> blocks)?  $default,) {final _that = this;
switch (_that) {
case _ReaderDocument() when $default != null:
return $default(_that.blocks);case _:
  return null;

}
}

}

/// @nodoc


class _ReaderDocument implements ReaderDocument {
  const _ReaderDocument({required  List<ReaderBlock> blocks}): _blocks = blocks;
  

 final  List<ReaderBlock> _blocks;
@override List<ReaderBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}


/// Create a copy of ReaderDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReaderDocumentCopyWith<_ReaderDocument> get copyWith => __$ReaderDocumentCopyWithImpl<_ReaderDocument>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReaderDocument&&const DeepCollectionEquality().equals(other._blocks, _blocks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_blocks));

@override
String toString() {
  return 'ReaderDocument(blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$ReaderDocumentCopyWith<$Res> implements $ReaderDocumentCopyWith<$Res> {
  factory _$ReaderDocumentCopyWith(_ReaderDocument value, $Res Function(_ReaderDocument) _then) = __$ReaderDocumentCopyWithImpl;
@override @useResult
$Res call({
 List<ReaderBlock> blocks
});




}
/// @nodoc
class __$ReaderDocumentCopyWithImpl<$Res>
    implements _$ReaderDocumentCopyWith<$Res> {
  __$ReaderDocumentCopyWithImpl(this._self, this._then);

  final _ReaderDocument _self;
  final $Res Function(_ReaderDocument) _then;

/// Create a copy of ReaderDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? blocks = null,}) {
  return _then(_ReaderDocument(
blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ReaderBlock>,
  ));
}


}

/// @nodoc
mixin _$ReaderBlock {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderBlock);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReaderBlock()';
}


}

/// @nodoc
class $ReaderBlockCopyWith<$Res>  {
$ReaderBlockCopyWith(ReaderBlock _, $Res Function(ReaderBlock) __);
}


/// Adds pattern-matching-related methods to [ReaderBlock].
extension ReaderBlockPatterns on ReaderBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SurahHeaderBlock value)?  surah,TResult Function( BasmalaBlock value)?  basmala,TResult Function( AyahBlock value)?  ayah,TResult Function( AttributionBlock value)?  attribution,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SurahHeaderBlock() when surah != null:
return surah(_that);case BasmalaBlock() when basmala != null:
return basmala(_that);case AyahBlock() when ayah != null:
return ayah(_that);case AttributionBlock() when attribution != null:
return attribution(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SurahHeaderBlock value)  surah,required TResult Function( BasmalaBlock value)  basmala,required TResult Function( AyahBlock value)  ayah,required TResult Function( AttributionBlock value)  attribution,}){
final _that = this;
switch (_that) {
case SurahHeaderBlock():
return surah(_that);case BasmalaBlock():
return basmala(_that);case AyahBlock():
return ayah(_that);case AttributionBlock():
return attribution(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SurahHeaderBlock value)?  surah,TResult? Function( BasmalaBlock value)?  basmala,TResult? Function( AyahBlock value)?  ayah,TResult? Function( AttributionBlock value)?  attribution,}){
final _that = this;
switch (_that) {
case SurahHeaderBlock() when surah != null:
return surah(_that);case BasmalaBlock() when basmala != null:
return basmala(_that);case AyahBlock() when ayah != null:
return ayah(_that);case AttributionBlock() when attribution != null:
return attribution(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Surah surah)?  surah,TResult Function()?  basmala,TResult Function( Ayah ayah)?  ayah,TResult Function( String text)?  attribution,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SurahHeaderBlock() when surah != null:
return surah(_that.surah);case BasmalaBlock() when basmala != null:
return basmala();case AyahBlock() when ayah != null:
return ayah(_that.ayah);case AttributionBlock() when attribution != null:
return attribution(_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Surah surah)  surah,required TResult Function()  basmala,required TResult Function( Ayah ayah)  ayah,required TResult Function( String text)  attribution,}) {final _that = this;
switch (_that) {
case SurahHeaderBlock():
return surah(_that.surah);case BasmalaBlock():
return basmala();case AyahBlock():
return ayah(_that.ayah);case AttributionBlock():
return attribution(_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Surah surah)?  surah,TResult? Function()?  basmala,TResult? Function( Ayah ayah)?  ayah,TResult? Function( String text)?  attribution,}) {final _that = this;
switch (_that) {
case SurahHeaderBlock() when surah != null:
return surah(_that.surah);case BasmalaBlock() when basmala != null:
return basmala();case AyahBlock() when ayah != null:
return ayah(_that.ayah);case AttributionBlock() when attribution != null:
return attribution(_that.text);case _:
  return null;

}
}

}

/// @nodoc


class SurahHeaderBlock implements ReaderBlock {
  const SurahHeaderBlock(this.surah);
  

 final  Surah surah;

/// Create a copy of ReaderBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahHeaderBlockCopyWith<SurahHeaderBlock> get copyWith => _$SurahHeaderBlockCopyWithImpl<SurahHeaderBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahHeaderBlock&&(identical(other.surah, surah) || other.surah == surah));
}


@override
int get hashCode => Object.hash(runtimeType,surah);

@override
String toString() {
  return 'ReaderBlock.surah(surah: $surah)';
}


}

/// @nodoc
abstract mixin class $SurahHeaderBlockCopyWith<$Res> implements $ReaderBlockCopyWith<$Res> {
  factory $SurahHeaderBlockCopyWith(SurahHeaderBlock value, $Res Function(SurahHeaderBlock) _then) = _$SurahHeaderBlockCopyWithImpl;
@useResult
$Res call({
 Surah surah
});


$SurahCopyWith<$Res> get surah;

}
/// @nodoc
class _$SurahHeaderBlockCopyWithImpl<$Res>
    implements $SurahHeaderBlockCopyWith<$Res> {
  _$SurahHeaderBlockCopyWithImpl(this._self, this._then);

  final SurahHeaderBlock _self;
  final $Res Function(SurahHeaderBlock) _then;

/// Create a copy of ReaderBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? surah = null,}) {
  return _then(SurahHeaderBlock(
null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as Surah,
  ));
}

/// Create a copy of ReaderBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahCopyWith<$Res> get surah {
  
  return $SurahCopyWith<$Res>(_self.surah, (value) {
    return _then(_self.copyWith(surah: value));
  });
}
}

/// @nodoc


class BasmalaBlock implements ReaderBlock {
  const BasmalaBlock();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BasmalaBlock);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReaderBlock.basmala()';
}


}




/// @nodoc


class AyahBlock implements ReaderBlock {
  const AyahBlock(this.ayah);
  

 final  Ayah ayah;

/// Create a copy of ReaderBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AyahBlockCopyWith<AyahBlock> get copyWith => _$AyahBlockCopyWithImpl<AyahBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AyahBlock&&(identical(other.ayah, ayah) || other.ayah == ayah));
}


@override
int get hashCode => Object.hash(runtimeType,ayah);

@override
String toString() {
  return 'ReaderBlock.ayah(ayah: $ayah)';
}


}

/// @nodoc
abstract mixin class $AyahBlockCopyWith<$Res> implements $ReaderBlockCopyWith<$Res> {
  factory $AyahBlockCopyWith(AyahBlock value, $Res Function(AyahBlock) _then) = _$AyahBlockCopyWithImpl;
@useResult
$Res call({
 Ayah ayah
});


$AyahCopyWith<$Res> get ayah;

}
/// @nodoc
class _$AyahBlockCopyWithImpl<$Res>
    implements $AyahBlockCopyWith<$Res> {
  _$AyahBlockCopyWithImpl(this._self, this._then);

  final AyahBlock _self;
  final $Res Function(AyahBlock) _then;

/// Create a copy of ReaderBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ayah = null,}) {
  return _then(AyahBlock(
null == ayah ? _self.ayah : ayah // ignore: cast_nullable_to_non_nullable
as Ayah,
  ));
}

/// Create a copy of ReaderBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AyahCopyWith<$Res> get ayah {
  
  return $AyahCopyWith<$Res>(_self.ayah, (value) {
    return _then(_self.copyWith(ayah: value));
  });
}
}

/// @nodoc


class AttributionBlock implements ReaderBlock {
  const AttributionBlock(this.text);
  

 final  String text;

/// Create a copy of ReaderBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttributionBlockCopyWith<AttributionBlock> get copyWith => _$AttributionBlockCopyWithImpl<AttributionBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttributionBlock&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'ReaderBlock.attribution(text: $text)';
}


}

/// @nodoc
abstract mixin class $AttributionBlockCopyWith<$Res> implements $ReaderBlockCopyWith<$Res> {
  factory $AttributionBlockCopyWith(AttributionBlock value, $Res Function(AttributionBlock) _then) = _$AttributionBlockCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$AttributionBlockCopyWithImpl<$Res>
    implements $AttributionBlockCopyWith<$Res> {
  _$AttributionBlockCopyWithImpl(this._self, this._then);

  final AttributionBlock _self;
  final $Res Function(AttributionBlock) _then;

/// Create a copy of ReaderBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(AttributionBlock(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
