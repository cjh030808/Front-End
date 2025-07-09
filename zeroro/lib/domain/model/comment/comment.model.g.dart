// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  postId: (json['postId'] as num).toInt(),
  uid: (json['uid'] as num).toInt(),
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'postId': instance.postId,
  'uid': instance.uid,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
};
