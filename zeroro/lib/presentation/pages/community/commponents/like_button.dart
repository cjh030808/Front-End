import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int initialCount;

  const LikeButton({super.key, this.initialCount = 0});

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
