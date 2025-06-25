import 'package:flutter/material.dart';
import 'package:zeroro/core/constants.dart';
import '../../../core/theme/constant/app_color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          // 프로필 정보 섹션
          SliverToBoxAdapter(child: _buildProfileInfoSection(theme)),

          // 차트 섹션
          SliverToBoxAdapter(child: _buildChartSection(theme)),

          // 게시글 리스트 섹션
          SliverToBoxAdapter(child: _buildPostsHeaderSection(theme)),

          // 게시글 그리드
          _buildPostsGrid(),
        ],
      ),
    );
  }

  Widget _buildProfileInfoSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20) + EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 프로필 사진
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 43,
                  backgroundColor: AppColors.primaryContainer,
                  backgroundImage: AssetImage("$baseImagePath/mock_image.jpg"),
                ),
              ),

              const SizedBox(width: 20),

              // 통계 정보
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn('게시물', '0', theme),
                    _buildStatColumn('팔로워', '0', theme),
                    _buildStatColumn('팔로잉', '0', theme),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 이름
          Text(
            '김오띠',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          // 닉네임
          Text(
            '@기모띠',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.secondary,
            ),
          ),

          const SizedBox(height: 16),

          // 프로필 편집 버튼
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryContainer),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '프로필 편집',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String count, ThemeData theme) {
    return Column(
      children: [
        Text(
          count,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildChartSection(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryContainer.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '내 성과 변화',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // 차트 공간 placeholder
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 48,
                    color: AppColors.secondary.withOpacity(0.6),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '점수 & 등수 변화 차트',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsHeaderSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            '내 게시글',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(Icons.grid_on, color: AppColors.secondary),
        ],
      ),
    );
  }

  Widget _buildPostsGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            color: AppColors.primaryContainer,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 임시 이미지 placeholder
                Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image,
                    size: 40,
                    color: AppColors.secondary,
                  ),
                ),

                // 게시글 정보 오버레이
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: 24, // 게시물 수와 일치
      ),
    );
  }
}
