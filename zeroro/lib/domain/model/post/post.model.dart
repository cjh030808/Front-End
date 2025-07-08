import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.model.freezed.dart';
part 'post.model.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String uid,
    required String content,
    String? imageUrl,
    required String likeCount,
    required DateTime createdAt,
    required String title,
    String? userImg,
    required String userName,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}
