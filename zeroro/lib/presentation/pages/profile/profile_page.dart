import 'package:flutter/material.dart';
import '../community/commponents/post_widget.dart';
import 'components/profile_info_section.dart';
import 'components/chart_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 정보 섹션
            const ProfileInfoSection(),

            // 차트 섹션
            const ChartSection(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '내 게시글',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 게시글 그리드
            _buildPostsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true, // 콘텐츠 크기에 맞게 축소
        physics: const NeverScrollableScrollPhysics(), // 상위 스크롤뷰에서 처리
        itemCount: 24,
        itemBuilder: (context, index) => PostWidget(
          userName: '김오띠',
          content: '게시글 내용 ${index + 1}',
          mediaUrls: [],
        ),
      ),
    );
  }
}
