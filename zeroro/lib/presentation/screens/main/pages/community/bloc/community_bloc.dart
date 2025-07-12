import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zeroro/core/constants.dart';
import 'package:zeroro/core/error_response.dart';
import 'package:zeroro/core/logger.dart';
import 'package:zeroro/domain/repository/community.repository.dart';
import 'package:zeroro/domain/model/post/post.model.dart';
import 'package:zeroro/domain/model/comment/comment.model.dart';


part 'community_event.dart';
part 'community_state.dart';
part 'community_bloc.freezed.dart';

@injectable
class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final CommunityRepository _repository;

  CommunityBloc(this._repository) : super(CommunityState()) {
    on<PostsInitialized>(_onPostsInitialized);
    on<LoadMorePosts>(_onLoadMorePosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
    on<CommentsInitialized>(_onCommentsInitialized);
    on<LoadMoreComments>(_onLoadMoreComments);
    on<CreateComment>(_onCreateComment);
    on<UpdateComment>(_onUpdateComment);
    on<DeleteComment>(_onDeleteComment);
  }

  // 게시글
  Future<void> _onPostsInitialized(
    PostsInitialized event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final posts = await _repository.getPosts(offset: 0);

      emit(
        state.copyWith(
          status: Status.success,
          postList: posts,
          offset: posts.length,
          shouldRefresh: false,
        ),
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
          shouldRefresh: false,
        ),
      );
    }
  }

  Future<void> _onLoadMorePosts(
    LoadMorePosts event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final posts = await _repository.getPosts(offset: state.offset);

      emit(
        state.copyWith(
          status: Status.success,
          postList: posts,
          offset: state.offset + 10,
        ),
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
        ),
      );
    }
  }

  Future<void> _onCreatePost(
    CreatePost event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _repository.createPost(
        userId: event.userId,
        title: event.title,
        content: event.content,
        imageUrl: event.imageUrl,
      );

      emit(state.copyWith(status: Status.success, shouldRefresh: true));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
        ),
      );
    }
  }

  Future<void> _onUpdatePost(
    UpdatePost event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      await _repository.updatePost(
        postId: event.postId,
        title: event.title,
        content: event.content,
        likesCount: event.likesCount,
        imageUrl: event.imageUrl,
      );

      emit(state.copyWith(status: Status.success, shouldRefresh: true));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
        ),
      );
    }
  }

  Future<void> _onDeletePost(
    DeletePost event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _repository.deletePost(postId: event.postId);

      emit(state.copyWith(status: Status.success, shouldRefresh: true));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
        ),
      );
    }
  }

  // 댓글

  Future<void> _onCommentsInitialized(
    CommentsInitialized event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final comments = await _repository.getComments(
        postId: state.postList.first.id,
      );

      emit(
        state.copyWith(
          status: Status.success,
          commentList: comments,
          shouldRefresh: false,
        ),
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
        ),
      );
    }
  }

  Future<void> _onLoadMoreComments(
    LoadMoreComments event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final comments = await _repository.getComments(postId: event.postId);

      emit(state.copyWith(status: Status.success, commentList: comments));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
        ),
      );
    }
  }

  Future<void> _onCreateComment(
    CreateComment event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _repository.createComment(
        postId: event.postId,
        comment: event.comment,
      );

      emit(state.copyWith(status: Status.success, shouldRefresh: true));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
        ),
      );
    }
  }

  Future<void> _onUpdateComment(
    UpdateComment event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _repository.updateComment(
        postId: event.postId,
        commentId: event.commentId,
        comment: event.comment,
      );

      emit(state.copyWith(status: Status.success, shouldRefresh: true));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
        ),
      );
    }
  }

  Future<void> _onDeleteComment(
    DeleteComment event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _repository.deleteComment(
        postId: event.postId,
        commentId: event.commentId,
      );

      emit(state.copyWith(status: Status.success, shouldRefresh: true));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          errorResponse: ErrorResponse(message: error.toString()),
        ),
      );
    }
  }
}
