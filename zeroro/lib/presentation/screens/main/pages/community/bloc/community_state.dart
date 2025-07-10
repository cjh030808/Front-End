part of 'community_bloc.dart';

@freezed
abstract class CommunityState with _$CommunityState {
  const factory CommunityState({
    @Default(Status.initial) Status status,
    @Default(ErrorResponse()) ErrorResponse errorResponse,
    @Default(0) int offset,
    @Default([]) List<Post> postList,
    @Default([]) List<Comment> commentList,
    @Default(false) bool shouldRefresh,
  }) = _CommunityState;
}
