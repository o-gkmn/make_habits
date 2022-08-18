part of 'day_tracker_bloc.dart';

abstract class DayTrackerEvent extends Equatable {
  const DayTrackerEvent();

  @override
  List<Object> get props => [];
}

class DayTrackerInitialEvent extends DayTrackerEvent {}

class DayTrackerLoadingEvent extends DayTrackerEvent {}

class DayTrackerLoadedEvent extends DayTrackerEvent {
  final List<HabitsModel> habits;

  const DayTrackerLoadedEvent(this.habits);

  @override
  List<Object> get props => [habits];
}

class DayTrackerErrorEvent extends DayTrackerEvent {}

class DayTrackerChangeEvent extends DayTrackerEvent {}
