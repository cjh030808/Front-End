import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/leaderboard_tab_bloc.dart';

class LeaderboardTabs extends StatelessWidget {
  const LeaderboardTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LeaderboardTabBloc>().state;
    final isDomestic = state is DomesticTabSelected;

    return Row(
      children: [
        _buildTab(context, '국내', isDomestic, SelectDomesticTab()),
        _buildTab(context, '국외', !isDomestic, SelectGlobalTab()),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String label, bool selected, LeaderboardTabEvent event) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<LeaderboardTabBloc>().add(event),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.blue[100] : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}