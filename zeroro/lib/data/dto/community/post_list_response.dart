import 'package:json_annotation/json_annotation.dart';
import '../../../domain/model/post/post.model.dart';

part 'post_list_response.g.dart';

@JsonSerializable()
class PostListResponse {
  final List<PostDto> posts;

  PostListResponse({required this.posts});

  factory PostListResponse.fromJson(Map<String, dynamic> json) =>
      _$PostListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostListResponseToJson(this);
}

@JsonSerializable()
class PostDto {
  final int id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String content;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String title;
  final ProfileDto profiles;

  PostDto({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrl,
    required this.likesCount,
    required this.createdAt,
    required this.title,
    required this.profiles,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostDtoToJson(this);

  // DTO를 Domain Model로 변환하는 mapper
  Post toDomain() {
    return Post(
      id: id,
      uid: userId,
      content: content,
      imageUrl: imageUrl,
      likeCount: likesCount,
      createdAt: DateTime.parse(createdAt),
      title: title,
      userImg: profiles.userImg,
      userName: profiles.username,
    );
  }
}

@JsonSerializable()
class ProfileDto {
  @JsonKey(name: 'user_img')
  final String? userImg;
  final String username;

  ProfileDto({
    this.userImg,
    required this.username,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}
