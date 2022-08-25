part of 'day_tracker_bloc.dart';

abstract class DayTrackerState extends Equatable {
  final Habit habit;

  const DayTrackerState({this.habit = const Habit.empty()});

  @override
  List<Object> get props => [];
}

class DayTrackerInitialState extends DayTrackerState {}

class DayTrackerLoadingState extends DayTrackerState {}

class DayTrackerLoadedState extends DayTrackerState {
  final Habit _habit;

  const DayTrackerLoadedState(this._habit) : super(habit: _habit);

  @override
  List<Object> get props => [_habit];
}

class DayTrackerErrorState extends DayTrackerState {
  final String e;

  const DayTrackerErrorState(this.e);

  @override
  List<Object> get props => [e];
}

class DayTrackerShowState extends DayTrackerState {}

class DayTrackerChangeState extends DayTrackerState {}
