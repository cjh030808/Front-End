import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.dto.g.dart';

@JsonSerializable()
class ProfileDto {
  final String id;
  final String username;
  @JsonKey(name: 'total_points') 
  final int totalPoints;
  @JsonKey(name: 'continuous_days')
  final int continuousDays;
  @JsonKey(name: 'last_active_at') 
  final String? lastActiveAt;
  @JsonKey(name: 'created_at') 
  final String createdAt;
  @JsonKey(name: 'user_img') 
  final String? userImg;

  ProfileDto({
   required this.id,
   required this.username,
   required this.totalPoints,
   required this.continuousDays,
   this.lastActiveAt,
   required this.createdAt,
   this.userImg,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);

    // DTO를 Domain Model로 변환하는 mapper
    // Profile toDomain() {
    //   return Profile(
    //     id: id,
    //     username: username,
    //     totalPoints: totalPoints,
    //     continuousDays: continuousDays,
    //     lastActiveAt: lastActiveAt != null ? DateTime.parse(lastActiveAt!) : null,
    //     createdAt: DateTime.parse(createdAt),
    //     userImg: userImg,
    //   );
    // }
}
