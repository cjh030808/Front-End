import 'package:injectable/injectable.dart';
import 'package:zeroro/core/logger.dart';

import '../../domain/model/comment/comment.model.dart';
import '../../domain/model/post/post.model.dart';
import '../../domain/repository/community.repository.dart';
import '../data_source/community/community.api.dart';
import '../dto/community/post.dto.dart';

@Singleton(as: CommunityRepository)
class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityApi _api;

  CommunityRepositoryImpl(this._api);

  @override
  Future<List<Post>> getPosts({required int offset}) async {
    try {
      final response = await _api.getPosts(offset);
      return response.posts.map((postDto) => postDto.toDomain()).toList();
    } catch (e) {
      throw Exception('게시글을 불러오는 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<Post> createPost({
    required String userId,
    required String title,
    required String content,
    String? imageUrl,
  }) async {
    try {
      final response = await _api.createPost(CreatePostDto(
        userId: userId,
        title: title,
        content: content,
        imageUrl: imageUrl,
      ));
      CustomLogger.logger.d(response.toDomain());
      return response.toDomain();
    } catch (e) {
      throw Exception('게시글 작성 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<Post> updatePost({
    required int postId,
    required String title,
    required String content,
    required int likesCount,
    String? imageUrl,
  }) async {
    try {
      final response = await _api.updatePost(postId, UpdatePostDto(
        title: title,
        content: content,
        likesCount: likesCount,
        imageUrl: imageUrl,
      ));

      return response.toDomain();
    } catch (e) {
      throw Exception('게시글 수정 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<void> deletePost({required int postId}) async {
    try {
      await _api.deletePost(postId);
    } catch (e) {
      throw Exception('게시글 삭제 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<List<Comment>> getComments({required int postId}) async {
    try {
      return await _api.getComments(postId);
    } catch (e) {
      throw Exception('댓글을 불러오는 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<Comment> createComment({required int postId, required Comment comment}) async {
    try {
      return await _api.createComment(postId, comment);
    } catch (e) {
      throw Exception('댓글 작성 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<Comment> updateComment({
    required int postId,
    required int commentId,
    required Comment comment,
  }) async {
    try {
      return await _api.updateComment(postId, commentId, comment.content);
    } catch (e) {
      throw Exception('댓글 수정 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<void> deleteComment({required int postId, required int commentId}) async {
    try {
      await _api.deleteComment(postId, commentId);
    } catch (e) {
      throw Exception('댓글 삭제 중 오류가 발생했습니다: $e');
    }
  }
}
