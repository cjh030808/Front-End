// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentListDto _$CommentListDtoFromJson(Map<String, dynamic> json) =>
    CommentListDto(
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentListDtoToJson(CommentListDto instance) =>
    <String, dynamic>{'comments': instance.comments};

CommentDto _$CommentDtoFromJson(Map<String, dynamic> json) => CommentDto(
  id: (json['id'] as num).toInt(),
  postId: (json['post_id'] as num).toInt(),
  userId: json['user_id'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  profiles: json['profiles'] as Map<String, dynamic>,
);

Map<String, dynamic> _$CommentDtoToJson(CommentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.postId,
      'user_id': instance.userId,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
      'profiles': instance.profiles,
    };

CreateCommentDto _$CreateCommentDtoFromJson(Map<String, dynamic> json) =>
    CreateCommentDto(
      userId: json['user_id'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$CreateCommentDtoToJson(CreateCommentDto instance) =>
    <String, dynamic>{'user_id': instance.userId, 'content': instance.content};
