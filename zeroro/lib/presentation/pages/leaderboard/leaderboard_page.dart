import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/leaderboard_tab_bloc.dart';
import 'leaderboard_tabs.dart';
import 'domestic_view.dart';
import 'global_view.dart';


class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LeaderboardTabBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('leaderboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 115), // 리더보드 크기
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LeaderboardTabs(),             // 국내 | 국외
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<LeaderboardTabBloc, LeaderboardTabState>(
                    builder: (context, state) {
                      if (state is DomesticTabSelected) {
                        return const DomesticView();  // 국내탭
                      } else {
                        return const GlobalView();  // 국외탭
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
