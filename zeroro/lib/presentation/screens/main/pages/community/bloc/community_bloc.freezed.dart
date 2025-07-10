// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityState {

 Status get status; ErrorResponse get errorResponse; int get offset; List<Post> get postList; List<Comment> get commentList; bool get shouldRefresh;
/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityStateCopyWith<CommunityState> get copyWith => _$CommunityStateCopyWithImpl<CommunityState>(this as CommunityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorResponse, errorResponse) || other.errorResponse == errorResponse)&&(identical(other.offset, offset) || other.offset == offset)&&const DeepCollectionEquality().equals(other.postList, postList)&&const DeepCollectionEquality().equals(other.commentList, commentList)&&(identical(other.shouldRefresh, shouldRefresh) || other.shouldRefresh == shouldRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorResponse,offset,const DeepCollectionEquality().hash(postList),const DeepCollectionEquality().hash(commentList),shouldRefresh);

@override
String toString() {
  return 'CommunityState(status: $status, errorResponse: $errorResponse, offset: $offset, postList: $postList, commentList: $commentList, shouldRefresh: $shouldRefresh)';
}


}

/// @nodoc
abstract mixin class $CommunityStateCopyWith<$Res>  {
  factory $CommunityStateCopyWith(CommunityState value, $Res Function(CommunityState) _then) = _$CommunityStateCopyWithImpl;
@useResult
$Res call({
 Status status, ErrorResponse errorResponse, int offset, List<Post> postList, List<Comment> commentList, bool shouldRefresh
});




}
/// @nodoc
class _$CommunityStateCopyWithImpl<$Res>
    implements $CommunityStateCopyWith<$Res> {
  _$CommunityStateCopyWithImpl(this._self, this._then);

  final CommunityState _self;
  final $Res Function(CommunityState) _then;

/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorResponse = null,Object? offset = null,Object? postList = null,Object? commentList = null,Object? shouldRefresh = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorResponse: null == errorResponse ? _self.errorResponse : errorResponse // ignore: cast_nullable_to_non_nullable
as ErrorResponse,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,postList: null == postList ? _self.postList : postList // ignore: cast_nullable_to_non_nullable
as List<Post>,commentList: null == commentList ? _self.commentList : commentList // ignore: cast_nullable_to_non_nullable
as List<Comment>,shouldRefresh: null == shouldRefresh ? _self.shouldRefresh : shouldRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityState].
extension CommunityStatePatterns on CommunityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status status,  ErrorResponse errorResponse,  int offset,  List<Post> postList,  List<Comment> commentList,  bool shouldRefresh)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
return $default(_that.status,_that.errorResponse,_that.offset,_that.postList,_that.commentList,_that.shouldRefresh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status status,  ErrorResponse errorResponse,  int offset,  List<Post> postList,  List<Comment> commentList,  bool shouldRefresh)  $default,) {final _that = this;
switch (_that) {
case _CommunityState():
return $default(_that.status,_that.errorResponse,_that.offset,_that.postList,_that.commentList,_that.shouldRefresh);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status status,  ErrorResponse errorResponse,  int offset,  List<Post> postList,  List<Comment> commentList,  bool shouldRefresh)?  $default,) {final _that = this;
switch (_that) {
case _CommunityState() when $default != null:
return $default(_that.status,_that.errorResponse,_that.offset,_that.postList,_that.commentList,_that.shouldRefresh);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityState implements CommunityState {
  const _CommunityState({this.status = Status.initial, this.errorResponse = const ErrorResponse(), this.offset = 0, final  List<Post> postList = const [], final  List<Comment> commentList = const [], this.shouldRefresh = false}): _postList = postList,_commentList = commentList;
  

@override@JsonKey() final  Status status;
@override@JsonKey() final  ErrorResponse errorResponse;
@override@JsonKey() final  int offset;
 final  List<Post> _postList;
@override@JsonKey() List<Post> get postList {
  if (_postList is EqualUnmodifiableListView) return _postList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_postList);
}

 final  List<Comment> _commentList;
@override@JsonKey() List<Comment> get commentList {
  if (_commentList is EqualUnmodifiableListView) return _commentList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_commentList);
}

@override@JsonKey() final  bool shouldRefresh;

/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityStateCopyWith<_CommunityState> get copyWith => __$CommunityStateCopyWithImpl<_CommunityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorResponse, errorResponse) || other.errorResponse == errorResponse)&&(identical(other.offset, offset) || other.offset == offset)&&const DeepCollectionEquality().equals(other._postList, _postList)&&const DeepCollectionEquality().equals(other._commentList, _commentList)&&(identical(other.shouldRefresh, shouldRefresh) || other.shouldRefresh == shouldRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorResponse,offset,const DeepCollectionEquality().hash(_postList),const DeepCollectionEquality().hash(_commentList),shouldRefresh);

@override
String toString() {
  return 'CommunityState(status: $status, errorResponse: $errorResponse, offset: $offset, postList: $postList, commentList: $commentList, shouldRefresh: $shouldRefresh)';
}


}

/// @nodoc
abstract mixin class _$CommunityStateCopyWith<$Res> implements $CommunityStateCopyWith<$Res> {
  factory _$CommunityStateCopyWith(_CommunityState value, $Res Function(_CommunityState) _then) = __$CommunityStateCopyWithImpl;
@override @useResult
$Res call({
 Status status, ErrorResponse errorResponse, int offset, List<Post> postList, List<Comment> commentList, bool shouldRefresh
});




}
/// @nodoc
class __$CommunityStateCopyWithImpl<$Res>
    implements _$CommunityStateCopyWith<$Res> {
  __$CommunityStateCopyWithImpl(this._self, this._then);

  final _CommunityState _self;
  final $Res Function(_CommunityState) _then;

/// Create a copy of CommunityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorResponse = null,Object? offset = null,Object? postList = null,Object? commentList = null,Object? shouldRefresh = null,}) {
  return _then(_CommunityState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorResponse: null == errorResponse ? _self.errorResponse : errorResponse // ignore: cast_nullable_to_non_nullable
as ErrorResponse,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,postList: null == postList ? _self._postList : postList // ignore: cast_nullable_to_non_nullable
as List<Post>,commentList: null == commentList ? _self._commentList : commentList // ignore: cast_nullable_to_non_nullable
as List<Comment>,shouldRefresh: null == shouldRefresh ? _self.shouldRefresh : shouldRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
