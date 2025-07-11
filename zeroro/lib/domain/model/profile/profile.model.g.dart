// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: json['id'] as String,
  username: json['username'] as String,
  totalPoints: (json['totalPoints'] as num).toInt(),
  continuousDays: (json['continuousDays'] as num).toInt(),
  lastActiveAt: json['lastActiveAt'] == null
      ? null
      : DateTime.parse(json['lastActiveAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  userImg: json['userImg'] as String?,
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'totalPoints': instance.totalPoints,
  'continuousDays': instance.continuousDays,
  'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'userImg': instance.userImg,
};
