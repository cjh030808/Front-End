import 'package:flutter_bloc/flutter_bloc.dart';

// 탭 이벤트 정의
abstract class LeaderboardTabEvent {}

class SelectDomesticTab extends LeaderboardTabEvent {}

class SelectGlobalTab extends LeaderboardTabEvent {}

// 탭 상태 정의
abstract class LeaderboardTabState {}

class DomesticTabSelected extends LeaderboardTabState {}

class GlobalTabSelected extends LeaderboardTabState {}

// Bloc 구현
class LeaderboardTabBloc extends Bloc<LeaderboardTabEvent, LeaderboardTabState> {
  LeaderboardTabBloc() : super(DomesticTabSelected()) {
    on<SelectDomesticTab>((event, emit) => emit(DomesticTabSelected()));
    on<SelectGlobalTab>((event, emit) => emit(GlobalTabSelected()));
  }
}