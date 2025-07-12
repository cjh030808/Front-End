import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int initialCount;
  final Function(bool isLiked, int likeCount)? onLikeToggle;

  const LikeButton({super.key, this.initialCount = 0, this.onLikeToggle});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    likeCount = widget.initialCount;
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount--;
      } else {
        likeCount++;
      }
      isLiked = !isLiked;
    });

    // 콜백 함수 호출 - 좋아요 상태와 개수 전달
    if (widget.onLikeToggle != null) {
      widget.onLikeToggle!(isLiked, likeCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.grey,
          ),
          onPressed: toggleLike,
        ),
        Text('$likeCount'),
      ],
    );
  }
}
