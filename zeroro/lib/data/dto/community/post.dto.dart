import 'package:json_annotation/json_annotation.dart';
import '../../../domain/model/post/post.model.dart';

part 'post.dto.g.dart';

@JsonSerializable()
class PostListDto {
  final List<PostDto> posts;

  PostListDto({required this.posts});

  factory PostListDto.fromJson(Map<String, dynamic> json) =>
      _$PostListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostListDtoToJson(this);
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
  @JsonKey(name: 'profiles')
  final Map<String, dynamic> profiles;

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
      userId: userId,
      content: content,
      imageUrl: imageUrl,
      likesCount: likesCount,
      createdAt: DateTime.parse(createdAt),
      title: title,
      userImg: profiles['user_img'] as String?,
      username: profiles['username'] as String? ?? 'Guest',
    );
  }
}

@JsonSerializable()
class CreatePostDto {
  @JsonKey(name: 'user_id')
  final String userId;
  final String title;
  final String content;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  CreatePostDto({
    required this.userId,
    required this.title,
    required this.content,
    this.imageUrl,
  });

  factory CreatePostDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostDtoToJson(this);
}

@JsonSerializable()
class UpdatePostDto {
  final String title;
  final String content;
  @JsonKey(name: 'likes_count')
  final int? likesCount;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  UpdatePostDto({
    required this.title,
    required this.content,
    this.likesCount,
    this.imageUrl,
  });

  factory UpdatePostDto.fromJson(Map<String, dynamic> json) =>
      _$UpdatePostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePostDtoToJson(this);
}


