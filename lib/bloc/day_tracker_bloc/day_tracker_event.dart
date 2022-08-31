part of 'day_tracker_bloc.dart';

abstract class DayTrackerEvent extends Equatable {
  const DayTrackerEvent();

  @override
  List<Object> get props => [];
}

class DayTrackerInitialEvent extends DayTrackerEvent {}

class DayTrackerChangeEvent extends DayTrackerEvent {
  final Habit habit;
  final String dayString;

  const DayTrackerChangeEvent(this.habit, this.dayString);

  @override
  List<Object> get props => [habit, dayString];
}
