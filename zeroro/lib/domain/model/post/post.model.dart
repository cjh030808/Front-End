import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.model.freezed.dart';
part 'post.model.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required int id,
    required String userId,
    required String title,
    required String content,
    String? imageUrl,
    required int likesCount,
    required DateTime createdAt,
    String? userImg,
    required String username,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
