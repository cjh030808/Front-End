import 'package:flutter/material.dart';
import 'package:zeroro/core/constants.dart';

import '../user_model.dart';

class PodiumList extends StatefulWidget {
  const PodiumList({super.key, required this.top3, this.height = 220.0});
  final List<User> top3;
  final double height;

  @override
  State<PodiumList> createState() => _PodiumListState();
}

class _PodiumListState extends State<PodiumList> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _thirdPlaceAnimation;
  late Animation<double> _secondPlaceAnimation;
  late Animation<double> _firstPlaceAnimation;

  @override
  void initState() {
    super.initState();

    // 메인 애니메이션 컨트롤러 (전체 시퀀스용)
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // 3등 애니메이션 (0.0 ~ 0.3초)
    _thirdPlaceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.4, curve: Curves.elasticOut),
      ),
    );

    // 2등 애니메이션 (0.3 ~ 0.6초)
    _secondPlaceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.7, curve: Curves.elasticOut),
      ),
    );

    // 1등 애니메이션 (0.6 ~ 1.0초)
    _firstPlaceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.elasticOut),
      ),
    );

    // 애니메이션 시작
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightRatio = widget.height / 220.0; // 기본 높이 대비 비율
    final profileSize = (50 * heightRatio).clamp(30.0, 50.0);

    // top3 리스트가 3개 미만인 경우 에러 방지
    if (widget.top3.length < 3) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: Text('리더보드 데이터가 부족합니다.')),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Row(
            children: [
              _buildAnimatedPodiumItem(
                user: widget.top3[2], // 3등
                topMargin: 60 * heightRatio,
                animation: _thirdPlaceAnimation,
                profileSize: profileSize,
              ),
              _buildAnimatedPodiumItem(
                user: widget.top3[0], // 1등
                topMargin: 40 * heightRatio,
                animation: _firstPlaceAnimation,
                profileSize: profileSize,
              ),
              _buildAnimatedPodiumItem(
                user: widget.top3[1], // 2등
                topMargin: 50 * heightRatio,
                animation: _secondPlaceAnimation,
                profileSize: profileSize,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedPodiumItem({
    required User user,
    required double topMargin,
    required Animation<double> animation,
    required double profileSize,
  }) {
    final heightRatio = widget.height / 220.0;
    final fontSize = (14 * heightRatio).clamp(10.0, 14.0);
    final padding = (20 * heightRatio).clamp(8.0, 20.0);

    return Expanded(
      child: Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: padding),
                margin: EdgeInsets.only(top: topMargin, bottom: 0),
                color: const Color.fromARGB(112, 127, 195, 251),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(fontSize: fontSize),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user.score.toString(),
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: topMargin / 2,
                left: 0,
                right: 0,
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      '$baseImagePath/mock_image.jpg',
                      width: profileSize,
                      height: profileSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
