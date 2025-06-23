import 'package:flutter/material.dart';
import 'package:leaderboard_ui/leaderboard_ui.dart';
import 'user_model.dart';

class PodiumView extends StatelessWidget {
  final List<User> top3;

  const PodiumView({super.key, required this.top3});

  @override
  Widget build(BuildContext context) {
    if (top3.length < 3) return const SizedBox();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RoundedGradientPodium(name: top3[1].name, circleText: '2'),
        RoundedGradientPodium(name: top3[0].name, circleText: '1'),
        RoundedGradientPodium(name: top3[2].name, circleText: '3'),
      ],
    );
  }
}