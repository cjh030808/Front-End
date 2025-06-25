import 'package:flutter/material.dart';

import 'rank_tile.dart';
import 'podium_list.dart';
import '../user_model.dart';

//todo: 유저 리스트는 bloc로 주입받아서 사용하도록 변경할 것 
class RankingView extends StatefulWidget {
  const RankingView({super.key});
  
  @override
  State<RankingView> createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {
  late ScrollController _scrollController;
  double _podiumHeight = 220.0;
  final double _minPodiumHeight = 120.0;
  final double _maxPodiumHeight = 220.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final maxOffset = 100.0; // 스크롤 100px 후 최소 높이가 됨

    double newHeight =
        _maxPodiumHeight -
        (offset / maxOffset) * (_maxPodiumHeight - _minPodiumHeight);
    newHeight = newHeight.clamp(_minPodiumHeight, _maxPodiumHeight);

    if (newHeight != _podiumHeight) {
      setState(() {
        _podiumHeight = newHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final podium = mockUsers.take(3).toList();
    final rest = mockUsers.skip(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const MyRankTile(rank: 27, name: '나', score: 920),
        PodiumList(top3: podium, height: _podiumHeight),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
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
