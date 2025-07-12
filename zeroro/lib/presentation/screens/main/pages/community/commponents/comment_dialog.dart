import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroro/domain/model/comment/comment.model.dart';
import 'package:zeroro/core/constants.dart';
import '../bloc/community_bloc.dart';
import 'comment_card.dart';

class CommentDialog extends StatefulWidget {
  final int postId;

  const CommentDialog({super.key, required this.postId});

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 댓글 목록 로드
    context.read<CommunityBloc>().add(LoadMoreComments(postId: widget.postId));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendComment() {
    final content = _controller.text.trim();
    if (content.isNotEmpty) {
      final comment = Comment(
        id: 0, // 서버에서 할당됨
        postId: widget.postId,
        userId: "10dcf52e-950f-4f39-98fc-b3a8fcbb320d", // 실제로는 현재 로그인한 사용자 ID
        content: content,
        createdAt: DateTime.now(),
        username: '김오띠',
        userImg: null,
      );

      context.read<CommunityBloc>().add(
        CreateComment(postId: widget.postId, comment: comment),
      );

      _controller.clear();
    }
  }

  void _deleteComment(int commentId) {
    context.read<CommunityBloc>().add(
      DeleteComment(postId: widget.postId, commentId: commentId),
    );
  }

  void _editComment(Comment comment, String newContent) {
    final updatedComment = comment.copyWith(content: newContent);

    context.read<CommunityBloc>().add(
      UpdateComment(
        postId: widget.postId,
        commentId: comment.id,
        comment: updatedComment,
      ),
    );
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
              child: BlocBuilder<CommunityBloc, CommunityState>(
                builder: (context, state) {
                  if (state.status == Status.loading &&
                      state.commentList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == Status.error) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.errorResponse?.message ?? '오류가 발생했습니다.',
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => context.read<CommunityBloc>().add(
                              LoadMoreComments(postId: widget.postId),
                            ),
                            child: const Text('다시 시도'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state.commentList.isEmpty) {
                    return const Center(
                      child: Text('아직 댓글이 없습니다.\n첫 번째 댓글을 작성해보세요!'),
                    );
                  }

                  return ListView.builder(
                    itemCount: state.commentList.length,
                    itemBuilder: (context, index) {
                      final comment = state.commentList[index];
                      final isMyComment =
                          comment.userId ==
                          "current_user_id"; // 실제로는 현재 사용자와 비교

                      return CommentCard(
                        userName: comment.userId, // 임시로 userId 사용
                        content: comment.content,
                        initialLikes: 0, // 임시로 0 사용
                        isMyComment: isMyComment,
                        onDelete: isMyComment
                            ? () => _deleteComment(comment.id)
                            : null,
                        onEdit: isMyComment
                            ? (newContent) => _editComment(comment, newContent)
                            : null,
                      );
                    },
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    maxLines: null,
                    onSubmitted: (_) => _sendComment(),
                  ),
                ),
                const SizedBox(width: 8),
                BlocBuilder<CommunityBloc, CommunityState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.status == Status.loading
                          ? null
                          : _sendComment,
                      child: state.status == Status.loading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('전송'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
