import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeroro/presentation/routes/route_path.dart';
import 'commponents/post_widget.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Community',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          PostWidget(
            userName: '사용자1',
            content: '이것은 첫 번째 게시글입니다.',
            mediaUrls: ['assets/images/mock_image.jpg'],
          ),
          SizedBox(height: 16),
          PostWidget(
            userName: '사용자2',
            content: '이것은 두 번째 게시글입니다. 이미지가 여러 장 있어요.',
            mediaUrls: [
              'assets/images/mock_image.jpg',
              'assets/images/mock_image.jpg',
            ],
          ),
          SizedBox(height: 16),
          PostWidget(
            userName: '사용자3',
            content: '세 번째 게시글. 텍스트만 있음.',
            mediaUrls: [],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePath.newPost);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
