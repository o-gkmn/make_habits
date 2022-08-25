part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object> get props => [];
}

class MainScreenInitialEvent extends MainScreenEvent {
  final int index;

  const MainScreenInitialEvent({this.index = 0});

  @override
  List<Object> get props => [index];
}

class MainScreenLoadingEvent extends MainScreenEvent {
  final List<Habit> habits;
  final int index;

  const MainScreenLoadingEvent(this.habits, {this.index = 0});

  @override
  List<Object> get props => [habits, index];
}
