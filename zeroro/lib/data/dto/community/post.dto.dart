import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../domain/model/post/post.model.dart';

part 'post.dto.g.dart';

@JsonSerializable()
class PostListDto {
  final List<PostDto> posts;

  PostListDto({required this.posts});

  factory PostListDto.fromJson(Map<String, dynamic> json) =>
      _$PostListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostListDtoToJson(this);
}

@JsonSerializable()
class PostDto {
  @JsonKey(name: 'id', fromJson: _intFromJson)
  final int id;
  @JsonKey(name: 'user_id', fromJson: _stringFromJson)
  final String userId;
  @JsonKey(fromJson: _stringFromJson)
  final String content;
  @JsonKey(name: 'image_url', fromJson: _nullableStringFromJson)
  final String? imageUrl;
  @JsonKey(name: 'likes_count', fromJson: _intFromJson)
  final int likesCount;
  @JsonKey(name: 'created_at', fromJson: _dateTimeFromJson)
  final DateTime createdAt;
  @JsonKey(fromJson: _stringFromJson)
  final String title;
  @JsonKey(name: 'profiles', fromJson: _mapFromJson)
  final Map<String, dynamic> profiles;

  PostDto({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrl,
    required this.likesCount,
    required this.createdAt,
    required this.title,
    required this.profiles,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostDtoToJson(this);

  // null 안전한 int 변환 함수
  static int _intFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // null 안전한 String 변환 함수
  static String _stringFromJson(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  // null 안전한 nullable String 변환 함수
  static String? _nullableStringFromJson(dynamic value) {
    if (value == null) return null;
    if (value.toString().isEmpty) return null;
    return value.toString();
  }

  // null 안전한 DateTime 변환 함수
  static DateTime _dateTimeFromJson(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  // null 안전한 Map 변환 함수
  static Map<String, dynamic> _mapFromJson(dynamic value) {
    if (value == null) return {};
    if (value is Map<String, dynamic>) return value;
    return {};
  }

  // DTO를 Domain Model로 변환하는 mapper
  Post toDomain() {
    return Post(
      id: id,
      userId: userId,
      content: content,
      imageUrl: imageUrl,
      likesCount: likesCount,
      createdAt: _formatDateTime(createdAt),
      title: title,
      userImg: _getProfileValue('user_img'),
      username: _getProfileValue('username') ?? 'Guest',
    );
  }

  // profiles 맵에서 안전하게 값을 가져오는 헬퍼 함수
  String? _getProfileValue(String key) {
    final value = profiles[key];
    if (value == null) return null;
    return value.toString();
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }
}

@JsonSerializable()
class CreatePostDto {
  @JsonKey(name: 'user_id')
  final String userId;
  final String title;
  final String content;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  CreatePostDto({
    required this.userId,
    required this.title,
    required this.content,
    this.imageUrl,
  });

  factory CreatePostDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostDtoToJson(this);
}

@JsonSerializable()
class UpdatePostDto {
  final String title;
  final String content;
  @JsonKey(name: 'likes_count')
  final int? likesCount;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  UpdatePostDto({
    required this.title,
    required this.content,
    this.likesCount,
    this.imageUrl,
  });

  factory UpdatePostDto.fromJson(Map<String, dynamic> json) =>
      _$UpdatePostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePostDtoToJson(this);
}
