part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object> get props => [];
}

class MainScreenInitialEvent extends MainScreenEvent {}

class MainScreenLoadingEvent extends MainScreenEvent {
  final List<HabitsModel> habits;
  final int index;

  const MainScreenLoadingEvent(this.habits, {this.index = 0});

  @override
  List<Object> get props => [habits, index];
}

class MainScreenLoadedEvent extends MainScreenEvent {}

class MainScreenErrorEvent extends MainScreenEvent {
  final String e;

  const MainScreenErrorEvent(this.e);

  @override
  List<Object> get props => [e];
}

class MainScreenCheckBoxEvent extends MainScreenEvent {
  final String today;
  final String yesterday;
  final String tommorow;

  final bool todayBool;
  final bool yesterdayBool;
  final bool tommorowBool;

  final double percent;

  const MainScreenCheckBoxEvent(this.today, this.tommorow, this.yesterday,
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
