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
    on<LoadPosts>(_onLoadPosts);
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
    on<LoadComments>(_onLoadComments);
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

      final posts = await _repository.getPosts(state.offset);

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

  Future<void> _onLoadPosts(
    LoadPosts event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final posts = await _repository.getPosts(state.offset);

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
      final newPost = await _repository.createPost(event.post);

      emit(
        state.copyWith(
          postList: [newPost, ...state.postList],
          shouldRefresh: true,
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

  Future<void> _onUpdatePost(
    UpdatePost event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      final updatedPost = await _repository.updatePost(
        event.postId,
        event.post,
      );

      final updatedPosts = state.postList.map((post) {
        return post.id == event.postId ? updatedPost : post;
      }).toList();

      emit(state.copyWith(postList: updatedPosts, shouldRefresh: true));
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
      await _repository.deletePost(event.postId);

      final updatedPosts = state.postList
          .where((post) => post.id != event.postId)
          .toList();

      emit(state.copyWith(postList: updatedPosts, shouldRefresh: true));
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

  Future<void> _onLoadComments(
    LoadComments event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      final comments = await _repository.getComments(event.postId);
      emit(state.copyWith(commentList: comments));
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
      final newComment = await _repository.createComment(
        event.postId,
        event.comment,
      );

      emit(
        state.copyWith(
          commentList: [newComment, ...state.commentList],
          shouldRefresh: true,
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

  Future<void> _onUpdateComment(
    UpdateComment event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      final updatedComment = await _repository.updateComment(
        event.postId,
        event.commentId,
        event.comment,
      );

      final updatedComments = state.commentList.map((comment) {
        return comment.id == event.commentId ? updatedComment : comment;
      }).toList();

      emit(state.copyWith(commentList: updatedComments, shouldRefresh: true));
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
      await _repository.deleteComment(event.postId, event.commentId);

      final updatedComments = state.commentList
          .where((comment) => comment.id != event.commentId)
          .toList();

      emit(state.copyWith(commentList: updatedComments, shouldRefresh: true));
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
