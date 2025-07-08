// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  uid: (json['uid'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  likeCount: (json['likeCount'] as num).toInt(),
  content: json['content'] as String,
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'uid': instance.uid,
  'createdAt': instance.createdAt.toIso8601String(),
  'likeCount': instance.likeCount,
  'content': instance.content,
};
