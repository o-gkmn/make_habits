part of 'main_screen_bloc.dart';

abstract class MainScreenState extends Equatable {
  final Habit habit;
  final WidgetValues widgetValues;

  const MainScreenState(
      {this.habit = const Habit.empty(),
      this.widgetValues = const WidgetValues.empty()});

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
  final Habit habit_;
  final WidgetValues widgetValues_;

  const MainScreenCheckBoxState(
      {required this.widgetValues_, required this.habit_})
      : super(habit: habit_, widgetValues: widgetValues_);

  @override
  List<Object> get props => [
        widgetValues_,
        habit_,
      ];
}
