part of 'day_tracker_bloc.dart';

abstract class DayTrackerEvent extends Equatable {
  const DayTrackerEvent();

  @override
  List<Object> get props => [];
}

class DayTrackerInitialEvent extends DayTrackerEvent {}

class DayTrackerChangeEvent extends DayTrackerEvent {}
