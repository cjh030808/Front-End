import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zeroro/core/theme/constant/app_color.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'auth_method/auth_image_page.dart';
import 'auth_method/auth_quiz_page.dart';
import '../../../../../core/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String? _resultMessage;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  Timer? _fadeTimer;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_fadeController);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _fadeTimer?.cancel();
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("$baseImagePath/mock_image.jpg"),
                const Text(
                  "( 캐릭터 들어갈 자리 )",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
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
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.9),
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
                MaterialPageRoute(builder: (_) => const AuthMethod1Page()),
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
