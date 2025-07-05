import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../routes/route_path.dart';
import '../../../core/env_config.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final supabase = Supabase.instance.client;

  Future<AuthResponse> _googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: EnvConfig.googleAndroidClientId,
      serverClientId: EnvConfig.googleWebClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 로고/제목
          const Text(
            'ZeroRo',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 16),

          // 부제목
          const Text(
            '친환경 라이프스타일을 시작해보세요',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 120),

          // 구글 로그인 버튼
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  AuthResponse authResponse = await _googleSignIn();
                  if (authResponse.session != null) {
                    context.go(RoutePath.main);
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('로그인 세션이 없습니다.')));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('로그인 중 오류가 발생했습니다: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/google.png',
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Google 계정으로 빠르게 시작하세요',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 구분선
          Row(
            children: [
              Expanded(child: Container(height: 1, color: Colors.grey[300])),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('또는', style: TextStyle(fontSize: 14)),
              ),
              Expanded(child: Container(height: 1, color: Colors.grey[300])),
            ],
          ),

          const SizedBox(height: 20),

          // 게스트 로그인 버튼
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                context.go(RoutePath.main);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey[400]!, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline, color: Colors.grey[700], size: 24),
                  const SizedBox(width: 12),
                  Text(
                    '게스트로 시작하기',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TODO:서비스 약관 텍스트
        ],
      ),
    );
  }
}
