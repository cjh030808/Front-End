import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.model.freezed.dart';
part 'comment.model.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required int uid,
    required DateTime createdAt,
    required int likeCount,
    required String content,
  }) = _Comment;

  factory Comment.fromJson(Map<String, Object?> json) =>
      _$CommentFromJson(json);
}
