import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'auth_method/auth_method_1_page.dart';
import 'auth_method/auth_method_2_page.dart';
import 'auth_method/auth_method_3_page.dart';
import '../../../../../core/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("$baseImagePath/mock_image.jpg"),
            Text("( 캐릭터 들어갈 자리 )", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.lightBlue[100],
        overlayOpacity: 0.3,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.image),
            label: 'AI 인증',
            backgroundColor: Colors.lightBlue[50],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AuthMethod1Page()),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.psychology),
            label: '퀴즈 인증',
            backgroundColor: Colors.lightBlue[50],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AuthMethod2Page()),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.note_add),
            label: '글 인증',
            backgroundColor: Colors.lightBlue[50],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AuthMethod3Page()),
              );
            },
          ),
        ],
      ),
    );
  }
}
