import '../model/comment/comment.model.dart';
import '../model/post/post.model.dart';

abstract class CommunityRepository {
  // 게시글 관련 메서드
  Future<List<Post>> getPosts({required int offset});

  Future<Post> createPost({
    required String userId,
    required String title,
    required String content,
    String? imageUrl,
  });

  Future<Post> updatePost({
    required int postId,
    required String title,
    required String content,
    required int likesCount,
    String? imageUrl,
  });

  Future<void> deletePost({required int postId});

  // 댓글 관련 메서드
  Future<List<Comment>> getComments({required int postId});

  Future<Comment> createComment({
    required int postId,
    required Comment comment,
  });

  Future<Comment> updateComment({
    required int postId,
    required int commentId,
    required Comment comment,
  });
  
  Future<void> deleteComment({required int postId, required int commentId});
}
