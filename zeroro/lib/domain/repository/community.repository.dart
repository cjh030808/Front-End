import '../model/comment/comment.model.dart';
import '../model/post/post.model.dart';

abstract class CommunityRepository {
  // 게시글 관련 메서드
  Future<List<Post>> getPosts(int offset);
  Future<Post> createPost(Post post);
  Future<Post> updatePost(int postId, Post post);
  Future<void> deletePost(int postId);

  // 댓글 관련 메서드
  Future<List<Comment>> getComments(int postId);
  Future<Comment> createComment(int postId, Comment comment);
  Future<Comment> updateComment(int postId, int commentId, Comment comment);
  Future<void> deleteComment(int postId, int commentId);
}
