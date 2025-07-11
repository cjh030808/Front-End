import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.model.freezed.dart';
part 'profile.model.g.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String username,
    required int totalPoints,
    required int continuousDays,
    DateTime? lastActiveAt,
    required DateTime createdAt,
    String? userImg,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
