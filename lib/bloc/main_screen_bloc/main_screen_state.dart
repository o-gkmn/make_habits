part of 'main_screen_bloc.dart';

abstract class MainScreenState extends Equatable {
  final Habit habit;
  const MainScreenState({this.habit = const Habit.empty()});

  @override
  List<Object> get props => [];
}

class MainScreenInitialState extends MainScreenState {}

class MainScreenLoadingState extends MainScreenState {
  final List<Habit> habits;
  final int index;

  const MainScreenLoadingState(this.habits, {this.index = 0});

  @override
  List<Object> get props => [habits, index];
}

class MainScreenLoadedState extends MainScreenState {}

class MainScreenErrorState extends MainScreenState {
  final String e;

  const MainScreenErrorState(this.e);

  @override
  List<Object> get props => [e];
}

class MainScreenCheckBoxState extends MainScreenState {
  final Habit _habit;
  final String today;
  final String yesterday;
  final String tommorow;

  final bool todayBool;
  final bool yesterdayBool;
  final bool tommorowBool;

  final double percent;

  const MainScreenCheckBoxState(
      this._habit,
      this.today,
      this.tommorow,
      this.yesterday,
      this.todayBool,
      this.tommorowBool,
      this.yesterdayBool,
      this.percent)
      : super(habit: _habit);

  @override
  List<Object> get props => [
        _habit,
        today,
        yesterday,
        tommorow,
        todayBool,
        yesterdayBool,
        tommorowBool,
        percent
      ];
}
