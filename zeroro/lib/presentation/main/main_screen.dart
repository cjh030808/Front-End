import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/community/community_page.dart';
import '../pages/home/home_page.dart';
import '../pages/leaderboard/leaderboard_page.dart';
import '../pages/profile/profile_page.dart';
import 'cubit/bottom_nav_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BlocBuilder<BottomNavCubit, BottomNav>(
            builder: (context, state) {
              return switch (state) {
                BottomNav.home => const HomePage(),
                BottomNav.profile => const ProfilePage(),
                BottomNav.leaderboard => const LeaderboardPage(),
                BottomNav.community => const CommunityPage(),
              };
            },
          ),
          Positioned(
            bottom: 25,
            left: 15,
            right: 15,
            child: const _BottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BlocBuilder<BottomNavCubit, BottomNav>(
        builder: (_, state) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                193,
                120,
                120,
                120,
              ).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(50),
            ),
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: state.index,
              onTap: (index) =>
                  context.read<BottomNavCubit>().changePage(index),
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: List.generate(
                BottomNav.values.length,
                (index) => BottomNavigationBarItem(
                  icon: BottomNav.values[index].icon,
                  label: BottomNav.values[index].title,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
