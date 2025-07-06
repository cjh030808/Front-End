import 'package:flutter/material.dart';
import 'comment_card.dart';

class CommentDialog extends StatefulWidget {
  const CommentDialog({super.key});

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  final TextEditingController _controller = TextEditingController();

  // 🔧 나중에 서버 데이터로 대체할 예정
  final List<Map<String, dynamic>> _comments = [
    {'userName': 'user1', 'content': '좋은 게시글이네요!', 'isReply': false},
    {'userName': 'user2', 'content': '동의합니다!', 'isReply': true},
    {'userName': 'user3', 'content': '감사합니다.', 'isReply': false},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendComment() {
    final comment = _controller.text.trim();
    if (comment.isNotEmpty) {
      setState(() {
        _comments.add({
          'userName': '나',
          'content': comment,
          'isReply': false, // 기본은 일반 댓글로 처리
        });
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            /// 상단
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '댓글',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(height: 16),

            /// 댓글 리스트
            Expanded(
              child: ListView.builder(
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  final c = _comments[index];
                  return CommentCard(
                    userName: c['userName'],
                    content: c['content'],
                    initialLikes: c['likes'] ?? 0,
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            /// 입력창
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '댓글을 입력하세요',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendComment,
                  child: const Text('전송'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
