// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  uid: json['uid'] as String,
  content: json['content'] as String,
  imageUrl: json['imageUrl'] as String?,
  likeCount: json['likeCount'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  title: json['title'] as String,
  userImg: json['userImg'] as String?,
  userName: json['userName'] as String,
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'uid': instance.uid,
  'content': instance.content,
  'imageUrl': instance.imageUrl,
  'likeCount': instance.likeCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'title': instance.title,
  'userImg': instance.userImg,
  'userName': instance.userName,
};
