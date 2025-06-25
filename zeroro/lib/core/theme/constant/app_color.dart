import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // 버튼, AppBar, FloatingActionButton 등 주요 인터페이스 요소에 사용
  static const Color primary = Color(0xFF30E836);
  // 배경이 primary 일 때, 그 위에 표시되는 텍스트나 아이콘 색 
  static const Color onPrimary = Color.fromARGB(255, 0, 0, 0);
  //primary보다는 덜 눈에 띄는, 보조 색. 필터, 선택된 탭, 강조 표시, 프로그래스 바 등 부차적인 정보에 사용
  static const Color secondary = Color(0xFF8B30E8);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFC7C7C7);

  static const Color error = Color(0xFFFF5645);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color positive = Color(0xFF74CD7C);
}