import 'package:json_annotation/json_annotation.dart';
import 'package:zeroro/domain/model/comment/comment.model.dart';

part 'comment.dto.g.dart';

@JsonSerializable()
class CommentListDto {
  final List<CommentDto> comments;

  CommentListDto({required this.comments});

  factory CommentListDto.fromJson(Map<String, dynamic> json) =>
      _$CommentListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentListDtoToJson(this);
}

@JsonSerializable()
class CommentDto {
  final int id;
  @JsonKey(name: 'post_id')
  final int postId;
  @JsonKey(name: 'user_id')
  final String userId;
  final String content;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final Map<String, dynamic> profiles;

  CommentDto({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.profiles,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);

  Comment toDomain() {
    return Comment(
      id: id,
      postId: postId,
      userId: userId,
      content: content,
      createdAt: createdAt,
      userImg: profiles['user_img'] as String?,
      username: profiles['username'] as String? ?? 'Guest',
    );
  }
}

@JsonSerializable()
class CreateCommentDto {
  @JsonKey(name: 'user_id')
  final String userId;
  final String content;

  CreateCommentDto({
    required this.userId,
    required this.content,
  });

  factory CreateCommentDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCommentDtoToJson(this);
}
