import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNav {home, profile, leaderboard, community}

class BottomNavCubit extends Cubit<BottomNav> {
  BottomNavCubit() : super(BottomNav.home);

  void changePage(int index) => emit(BottomNav.values[index]);
}

extension BottomNavX on BottomNav {
  //todo: icon 에셋 추가 시, 수정 필요함
  Icon get icon => switch (this) {
    BottomNav.home => const Icon(Icons.home),
    BottomNav.profile => const Icon(Icons.person),
    BottomNav.leaderboard => const Icon(Icons.bar_chart),
    BottomNav.community => const Icon(Icons.people),
  };

  String get title => switch (this) {
    BottomNav.home => '홈',
    BottomNav.profile => '프로필',
    BottomNav.leaderboard => '리더보드',
    BottomNav.community => '커뮤니티',
  };
}
