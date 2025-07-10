// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: (json['id'] as num).toInt(),
  postId: (json['postId'] as num).toInt(),
  uid: json['uid'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': instance.id,
  'postId': instance.postId,
  'uid': instance.uid,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
};
