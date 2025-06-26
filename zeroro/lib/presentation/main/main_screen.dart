import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/community/community_page.dart';
import '../pages/home/home_page.dart';
import '../pages/leaderboard/leaderboard_page.dart';
import '../pages/profile/profile_page.dart';
import 'cubit/bottom_nav_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavCubit, BottomNav>(
          builder: (context, state) {
            return switch (state) {
              BottomNav.home => const HomePage(),
              BottomNav.profile => const ProfilePage(),
              BottomNav.leaderboard => const LeaderboardPage(),
              BottomNav.community => const CommunityPage(),
            };
          },
        ),
        bottomNavigationBar: const _BottomNavigationBar(),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: SizedBox(
          height: 70,
          child: BlocBuilder<BottomNavCubit, BottomNav>(
            builder: (_, state) {
              return BottomNavigationBar(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
