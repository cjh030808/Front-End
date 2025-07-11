// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostListDto _$PostListDtoFromJson(Map<String, dynamic> json) => PostListDto(
  posts: (json['posts'] as List<dynamic>)
      .map((e) => PostDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PostListDtoToJson(PostListDto instance) =>
    <String, dynamic>{'posts': instance.posts};

PostDto _$PostDtoFromJson(Map<String, dynamic> json) => PostDto(
  id: PostDto._intFromJson(json['id']),
  userId: PostDto._stringFromJson(json['user_id']),
  content: PostDto._stringFromJson(json['content']),
  imageUrl: PostDto._nullableStringFromJson(json['image_url']),
  likesCount: PostDto._intFromJson(json['likes_count']),
  createdAt: PostDto._dateTimeFromJson(json['created_at']),
  title: PostDto._stringFromJson(json['title']),
  profiles: PostDto._mapFromJson(json['profiles']),
);

Map<String, dynamic> _$PostDtoToJson(PostDto instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'content': instance.content,
  'image_url': instance.imageUrl,
  'likes_count': instance.likesCount,
  'created_at': instance.createdAt.toIso8601String(),
  'title': instance.title,
  'profiles': instance.profiles,
};

CreatePostDto _$CreatePostDtoFromJson(Map<String, dynamic> json) =>
    CreatePostDto(
      userId: json['user_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$CreatePostDtoToJson(CreatePostDto instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'image_url': instance.imageUrl,
    };

UpdatePostDto _$UpdatePostDtoFromJson(Map<String, dynamic> json) =>
    UpdatePostDto(
      title: json['title'] as String,
      content: json['content'] as String,
      likesCount: (json['likes_count'] as num?)?.toInt(),
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$UpdatePostDtoToJson(UpdatePostDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'likes_count': instance.likesCount,
      'image_url': instance.imageUrl,
    };
