import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:zeroro/core/logger.dart';
import 'package:zeroro/core/theme/constant/app_color.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'auth_method/auth_image_page.dart';
import 'auth_method/auth_quiz_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String? _resultMessage;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  Timer? _fadeTimer;
  Timer? _animationTimer; // 애니메이션 간격 타이머 추가

  Flutter3DController _3DController = Flutter3DController();

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_fadeController);

    // 3D 모델 로드 상태 리스너 추가
    _3DController.onModelLoaded.addListener(() {
      if (_3DController.onModelLoaded.value) {
        // 모델이 로드되면 사용 가능한 애니메이션 확인 후 재생
        _loadAndPlayAnimation();
      }
    });
  }

  // 3D 모델 애니메이션 로드 및 재생
  Future<void> _loadAndPlayAnimation() async {
    try {
      // 사용 가능한 애니메이션 목록 가져오기
      final animations = await _3DController.getAvailableAnimations();
      CustomLogger.logger.d('사용 가능한 애니메이션: $animations');

      if (animations != null && animations.isNotEmpty) {
        // 애니메이션 간격 실행 시작
        _startAnimationWithInterval(animations[0]);
      } else {
        // 기본 애니메이션으로 간격 실행
        _startAnimationWithInterval(null);
      }
    } catch (e) {
      CustomLogger.logger.e('애니메이션 재생 오류: $e');
    }
  }

  // 애니메이션을 간격을 두고 반복 실행
  void _startAnimationWithInterval(String? animationName) {
    // 기존 타이머가 있다면 취소
    _animationTimer?.cancel();

    // 첫 번째 애니메이션 즉시 재생
    _playAnimationOnce(animationName);

    // 3초 간격으로 애니메이션 반복 (간격 조정 가능)
    _animationTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _playAnimationOnce(animationName);
    });
  }

  // 애니메이션을 한 번만 재생
  void _playAnimationOnce(String? animationName) {
    if (animationName != null) {
      _3DController.playAnimation(
        animationName: animationName,
        loopCount: 1, // 한 번만 재생
      );
      CustomLogger.logger.d('애니메이션 재생: $animationName');
    } else {
      _3DController.playAnimation(loopCount: 1);
      CustomLogger.logger.d('기본 애니메이션 재생');
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _fadeTimer?.cancel();
    _animationTimer?.cancel(); // 애니메이션 타이머 정리
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/zeroro_logo_design5.png',
          height: 60,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Flutter3DViewer(
              controller: _3DController,
              src: "assets/zeroro/co2_zeroro_2.glb",
              onProgress: (double progress) {
                CustomLogger.logger.d('로딩 진행: $progress');
              },
              onLoad: (String modelAddress) {
                CustomLogger.logger.d('모델 로드 완료: $modelAddress');
              },
              onError: (String error) {
                CustomLogger.logger.e('오류: $error');
              },
            ),
          ),
          if (_resultMessage != null)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _resultMessage!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.lightBlue[100],
        overlayOpacity: 0.3,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.image),
            label: '사진 인증',
            backgroundColor: Colors.lightBlue[50],
            onTap: () async {
              final result = await Navigator.push<String>(
                context,
                MaterialPageRoute(builder: (_) => const AuthImagePage()),
              );

              if (result != null && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result),
                    backgroundColor: AppColors.positive,
                    behavior: SnackBarBehavior.fixed,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.psychology),
            label: '퀴즈 인증',
            backgroundColor: Colors.lightBlue[50],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AuthQuizPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
