import 'package:flutter/material.dart';
import 'like_button.dart';
import 'comment_dialog.dart';

class PostWidget extends StatelessWidget {
  final String userName;
  final String content;
  final List<String> mediaUrls;
  final int initialLikeCount;

  const PostWidget({
    super.key,
    required this.userName,
    required this.content,
    required this.mediaUrls,
    this.initialLikeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 18, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (content.isNotEmpty)
              Text(
                content,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 12),
            if (mediaUrls.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  mediaUrls.first,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                LikeButton(initialCount: initialLikeCount), // 하트 버튼
                const SizedBox(width: 24),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      builder: (_) => const CommentDialog(),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
