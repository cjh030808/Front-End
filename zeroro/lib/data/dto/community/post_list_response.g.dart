// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostListResponse _$PostListResponseFromJson(Map<String, dynamic> json) =>
    PostListResponse(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => PostDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostListResponseToJson(PostListResponse instance) =>
    <String, dynamic>{'posts': instance.posts};

PostDto _$PostDtoFromJson(Map<String, dynamic> json) => PostDto(
  id: (json['id'] as num).toInt(),
  userId: json['user_id'] as String,
  content: json['content'] as String,
  imageUrl: json['image_url'] as String?,
  likesCount: (json['likes_count'] as num).toInt(),
  createdAt: json['created_at'] as String,
  title: json['title'] as String,
  profiles: ProfileDto.fromJson(json['profiles'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PostDtoToJson(PostDto instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'content': instance.content,
  'image_url': instance.imageUrl,
  'likes_count': instance.likesCount,
  'created_at': instance.createdAt,
  'title': instance.title,
  'profiles': instance.profiles,
};

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => ProfileDto(
  userImg: json['user_img'] as String?,
  username: json['username'] as String,
);

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) =>
    <String, dynamic>{
      'user_img': instance.userImg,
      'username': instance.username,
    };
