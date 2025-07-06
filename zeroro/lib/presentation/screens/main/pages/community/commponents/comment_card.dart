import 'package:flutter/material.dart';
import 'like_button.dart'; // 하트 버튼 위젯 import

class CommentCard extends StatelessWidget {
  final String userName;
  final String content;
  final int initialLikes;

  const CommentCard({
    super.key,
    required this.userName,
    required this.content,
    this.initialLikes = 0,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 유저명
            Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            /// 댓글 내용
            Text(content),

            const SizedBox(height: 8),

            /// 하트 버튼 (좋아요)
            Row(
              children: [
                LikeButton(initialCount: initialLikes),
              ],
            ),
          ],
        ),
      ),
    );
  }
}