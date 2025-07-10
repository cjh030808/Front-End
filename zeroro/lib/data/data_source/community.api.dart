import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/model/comment/comment.model.dart';
import '../../domain/model/post/post.model.dart';

part 'community.api.g.dart';

@Singleton()
@RestApi(baseUrl: 'http://127.0.0.1:8000/api/v1/community')
abstract class CommunityApi {
  factory CommunityApi(Dio dio, {String? baseUrl}) = _CommunityApi;

  // 게시글
  @GET('/posts')
  Future<List<Post>> getPosts(@Query('offset') int offset);

  @POST('/posts')
  Future<Post> createPost(@Body() Post post);

  @PUT('/posts/{post_id}')
  Future<Post> updatePost(@Path('post_id') int postId, @Body() Post post);

  @DELETE('/posts/{post_id}')
  Future<void> deletePost(@Path('post_id') int postId);

  // 댓글
  @GET('/posts/{post_id}/comments')
  Future<List<Comment>> getComments(@Path('post_id') int postId);

  @POST('/posts/{post_id}/comments')
  Future<Comment> createComment(
    @Path('post_id') int postId,
    @Body() Comment comment,
  );

  @PUT('/posts/{post_id}/comments/{comment_id}')
  Future<Comment> updateComment(
    @Path('post_id') int postId,
    @Path('comment_id') int commentId,
    @Query('comment_data') String commentData,
  );

  @DELETE('/posts/{post_id}/comments/{comment_id}')
  Future<void> deleteComment(
    @Path('post_id') int postId,
    @Path('comment_id') int commentId,
  );
}
