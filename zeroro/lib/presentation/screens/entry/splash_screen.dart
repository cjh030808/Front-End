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

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if(mounted) {
        if(_isLoggedIn) {
          context.go(RoutePath.main);
        } else {
          context.go(RoutePath.login);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/animation/zeroro2.riv',
          controllers: [SimpleAnimation('Timeline 1')],
        ),
      ),
    );
  }
}