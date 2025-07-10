part of 'community_bloc.dart';

abstract class CommunityEvent {}

class PostsInitialized extends CommunityEvent {
  PostsInitialized();
}

class LoadPosts extends CommunityEvent {
  final int offset;

  LoadPosts({required this.offset});
}

class CreatePost extends CommunityEvent {
  final Post post;

  CreatePost({required this.post});
}

class UpdatePost extends CommunityEvent {
  final int postId;
  final Post post;

  UpdatePost({required this.post, required this.postId});
}

class DeletePost extends CommunityEvent {
  final int postId;

  DeletePost({required this.postId});
}

class LoadComments extends CommunityEvent {
  final int postId;

  LoadComments({required this.postId});
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
