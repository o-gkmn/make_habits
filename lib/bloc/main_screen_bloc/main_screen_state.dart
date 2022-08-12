part of 'main_screen_bloc.dart';

abstract class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object> get props => [];
}

class MainScreenInitialState extends MainScreenState {}

class MainScreenLoadingState extends MainScreenState {}

class MainScreenLoadedState extends MainScreenState {
  final List<HabitsModel> habits;
  final int index;

  const MainScreenLoadedState(this.habits, {this.index = 0});

  @override
  List<Object> get props => [habits, index];
}

class MainScreenErrorState extends MainScreenState {
  final String e;

  const MainScreenErrorState(this.e);

  @override
  List<Object> get props => [e];
}

class MainScreenCheckBoxState extends MainScreenState {
  final String today;
  final String yesterday;
  final String tommorow;

  final bool todayBool;
  final bool yesterdayBool;
  final bool tommorowBool;

  final double percent;

  const MainScreenCheckBoxState(this.today, this.tommorow, this.yesterday,
      this.todayBool, this.tommorowBool, this.yesterdayBool, this.percent);

  @override
  List<Object> get props => [
        today,
        yesterday,
        tommorow,
        todayBool,
        yesterdayBool,
        tommorowBool,
        percent
      ];
}
