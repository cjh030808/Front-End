import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/route_path.dart';

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
    Future.delayed(const Duration(milliseconds: 1500), () {
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
    return const Scaffold(
      body: Center(child: Text('ZeroRo',style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),)),
    );
  }
}