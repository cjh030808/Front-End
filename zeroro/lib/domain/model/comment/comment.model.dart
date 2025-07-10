import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.model.freezed.dart';
part 'comment.model.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required int id,
    required int postId,
    required String uid,
    required String content,
    required DateTime createdAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, Object?> json) =>
      _$CommentFromJson(json);
}
