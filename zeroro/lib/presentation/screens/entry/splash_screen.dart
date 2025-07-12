import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/route_path.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoggedIn = false;
  bool _isAnimationLoaded = false;
  RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();
    // 기본 SimpleAnimation 사용
    _controller = SimpleAnimation('Timeline 1');
  }

  void _navigateToNextScreen() {
    if (_isLoggedIn) {
      context.go(RoutePath.main);
    } else {
      context.go(RoutePath.login);
    }
  }

  void _onRiveInit(Artboard artboard) {
    setState(() {
      _isAnimationLoaded = true;
    });

    // 애니메이션이 로드된 후 1초 뒤에 애니메이션 시작
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _controller?.isActive = true;

        // 애니메이션이 시작된 후 8초 뒤에 다음 화면으로 이동
        Future.delayed(const Duration(seconds: 4), () {
          if (mounted) {
            _navigateToNextScreen();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 또는 브랜드 컬러
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 애니메이션 영역
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 애니메이션이 로드되지 않았을 때 로딩 인디케이터와 텍스트
                  if (!_isAnimationLoaded)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '로딩 중...',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                  // Rive 애니메이션
                  RiveAnimation.asset(
                    'assets/animation/zeroro4.riv',
                    controllers: [_controller!],
                    onInit: _onRiveInit,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}