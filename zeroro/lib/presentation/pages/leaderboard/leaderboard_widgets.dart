import 'package:flutter/material.dart';

class MyRankTile extends StatelessWidget {
  final int rank;
  final String name;
  final int score;

  const MyRankTile({required this.rank, required this.name, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('내 순위: $rank위', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('$name - $score점'),
        ],
      ),
    );
  }
}

class RankTile extends StatelessWidget {
  final int rank;
  final String name;
  final int score;

  const RankTile({required this.rank, required this.name, required this.score});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('$rank위'),
      title: Row(
        children: [
          //  프로필 자리는 추후 구현될 ProfileWidget으로 대체 예정
          const CircleAvatar(radius: 14, backgroundColor: Colors.grey),
          const SizedBox(width: 8),
          Text(name),
        ],
      ),
      trailing: Text('$score점'),
    );
  }
}
