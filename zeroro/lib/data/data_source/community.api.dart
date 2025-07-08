import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/model/comment/comment.model.dart';
import '../../domain/model/post/post.model.dart';

part 'community.api.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1:8000/api/v1/community')
abstract class CommunityApi {
  factory CommunityApi(Dio dio, {String? baseUrl}) = _CommunityApi;

  @GET('/posts')
  Future<List<Post>> getPosts(@Query('offset') int offset);

  @POST('/posts')
  Future<Post> createPost(@Body() Post post);

  @PUT('/posts/{id}')
  Future<Post> updatePost(@Path('id') int id, @Body() Post post);

  @DELETE('/posts/{id}')
  Future<void> deletePost(@Path('id') int id);

  @GET('/posts/{postId}/comments')
  Future<List<Comment>> getComments(@Path('postId') int postId);

  @POST('/posts/{postId}/comments')
  Future<Comment> createComment(
    @Path('postId') int postId,
    @Body() Comment comment,
  );

  @PUT('/posts/{postId}/comments/{commentId}')
  Future<Comment> updateComment(
    @Path('postId') int postId,
    @Path('commentId') int commentId,
    @Body() Comment comment,
  );

  @DELETE('/posts/{postId}/comments/{commentId}')
  Future<void> deleteComment(
    @Path('postId') int postId,
    @Path('commentId') int commentId,
  );
}
