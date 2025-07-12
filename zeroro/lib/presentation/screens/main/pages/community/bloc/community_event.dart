part of 'community_bloc.dart';

abstract class CommunityEvent {}

class PostsInitialized extends CommunityEvent {
  PostsInitialized();
}

class LoadMorePosts extends CommunityEvent {
  final int offset;

  LoadMorePosts({required this.offset});
}

class CreatePost extends CommunityEvent {
  final String userId;
  final String title;
  final String content;
  final String? imageUrl;

  CreatePost({
    required this.userId,
    required this.title,
    required this.content,
    this.imageUrl,
  });
}

class UpdatePost extends CommunityEvent {
  final int postId;
  final String title;
  final String content;
  final int likesCount;
  final String? imageUrl;

  UpdatePost({
    required this.postId,
    required this.title,
    required this.content,
    required this.likesCount,
    this.imageUrl,
  });
}

class DeletePost extends CommunityEvent {
  final int postId;

  DeletePost({required this.postId});
}

class CommentsInitialized extends CommunityEvent {
  CommentsInitialized();
}

class LoadMoreComments extends CommunityEvent {
  final int postId;

  LoadMoreComments({required this.postId});
}

class CreateComment extends CommunityEvent {
  final int postId;
  final Comment comment;

  CreateComment({required this.postId, required this.comment});
}

class UpdateComment extends CommunityEvent {
  final int postId;
  final int commentId;
  final Comment comment;

  UpdateComment({
    required this.postId,
    required this.commentId,
    required this.comment,
  });
}

class DeleteComment extends CommunityEvent {
  final int postId;
  final int commentId;

  DeleteComment({required this.postId, required this.commentId});
}
