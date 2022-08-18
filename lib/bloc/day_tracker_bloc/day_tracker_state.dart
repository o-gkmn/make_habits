part of 'day_tracker_bloc.dart';

abstract class DayTrackerState extends Equatable {
  const DayTrackerState();

  @override
  List<Object> get props => [];
}

class DayTrackerInitialState extends DayTrackerState {}

class DayTrackerLoadingState extends DayTrackerState {}

class DayTrackerLoadedState extends DayTrackerState {
  final HabitsModel habit;

  const DayTrackerLoadedState(this.habit);

  @override
  List<Object> get props => [habit];
}

class DayTrackerErrorState extends DayTrackerState {
  final String e;

  const DayTrackerErrorState(this.e);

  @override
  List<Object> get props => [e];
}

class DayTrackerShowState extends DayTrackerState {}

class DayTrackerChangeState extends DayTrackerState {}
