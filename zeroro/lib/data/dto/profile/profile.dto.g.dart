// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => ProfileDto(
  id: json['id'] as String,
  username: json['username'] as String,
  totalPoints: (json['total_points'] as num).toInt(),
  continuousDays: (json['continuous_days'] as num).toInt(),
  lastActiveAt: json['last_active_at'] as String?,
  createdAt: json['created_at'] as String,
  userImg: json['user_img'] as String?,
);

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'total_points': instance.totalPoints,
      'continuous_days': instance.continuousDays,
      'last_active_at': instance.lastActiveAt,
      'created_at': instance.createdAt,
      'user_img': instance.userImg,
    };
