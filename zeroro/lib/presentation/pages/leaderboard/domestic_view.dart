import 'package:flutter/material.dart';
import 'leaderboard_widgets.dart';
import 'podium_view.dart';
import 'user_model.dart';

class DomesticView extends StatelessWidget {
  const DomesticView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<User> users = List.generate(
      50,
          (index) => User('유저 ${index + 1}', 1000 - (index * 10)),
    );

    final podium = users.take(3).toList();
    final rest = users.skip(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyRankTile(rank: 27, name: '나', score: 920),
        const SizedBox(height: 16),
        PodiumView(top3: podium),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: rest.length,
            itemBuilder: (context, index) {
              final user = rest[index];
              final rank = index + 4;
              return RankTile(rank: rank, name: user.name, score: user.score);
            },
          ),
        ),
      ],
    );
  }
}
