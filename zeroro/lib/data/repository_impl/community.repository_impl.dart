import '../../domain/model/comment/comment.model.dart';
import '../../domain/model/post/post.model.dart';
import '../../domain/repository/community.repository.dart';
import '../data_source/community.api.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityApi _api;

  CommunityRepositoryImpl(this._api);

  @override
  Future<List<Post>> getPosts(int offset) async {
    try {
      return await _api.getPosts(offset);
    } catch (e) {
      throw Exception('게시글을 불러오는 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<Post> createPost(Post post) async {
    try {
      return await _api.createPost(post);
    } catch (e) {
      throw Exception('게시글 작성 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<Post> updatePost(int id, Post post) async {
    try {
      return await _api.updatePost(id, post);
    } catch (e) {
      throw Exception('게시글 수정 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      await _api.deletePost(id);
    } catch (e) {
      throw Exception('게시글 삭제 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<List<Comment>> getComments(int postId) async {
    try {
      return await _api.getComments(postId);
    } catch (e) {
      throw Exception('댓글을 불러오는 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<Comment> createComment(int postId, Comment comment) async {
    try {
      return await _api.createComment(postId, comment);
    } catch (e) {
      throw Exception('댓글 작성 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<Comment> updateComment(
    int postId,
    int commentId,
    Comment comment,
  ) async {
    try {
      return await _api.updateComment(postId, commentId, comment.content);
    } catch (e) {
      throw Exception('댓글 수정 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<void> deleteComment(int postId, int commentId) async {
    try {
      await _api.deleteComment(postId, commentId);
    } catch (e) {
      throw Exception('댓글 삭제 중 오류가 발생했습니다: $e');
    }
  }
}
