import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.dto.g.dart';

@JsonSerializable()
class UserDto {
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

  UserDto({
    required this.id,
    required this.username,
    required this.totalPoints,
    required this.continuousDays,
    this.lastActiveAt,
    required this.createdAt,
    this.userImg,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

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

@JsonSerializable()
class CreateUserRequest {
  final String username;
  final String email;
  final String password;

  CreateUserRequest({
    required this.username,
    required this.password,
    required this.email,
  });

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);
}

@JsonSerializable()
class CreateUserResponse {
  final UserInfo user;

  CreateUserResponse({required this.user});

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserResponseToJson(this);
}

@JsonSerializable()
class UserInfo {
  @JsonKey(name: 'user_id')
  final String userId;
  final String username;
  final String email;

  UserInfo({required this.userId, required this.username, required this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class UpdateUserRequest {
  final String? username;
  final String? email;

  UpdateUserRequest({this.username, this.email});

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}

@JsonSerializable()
class UpdateUserResponse {
  final UserInfo user;

  UpdateUserResponse({required this.user});

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserResponseToJson(this);
}
