import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_repository/habit_repository.dart';

part 'day_tracker_event.dart';
part 'day_tracker_state.dart';

class DayTrackerBloc extends Bloc<DayTrackerEvent, DayTrackerState> {
  int index;
  HabitRepository service;

  DayTrackerBloc(this.service, this.index) : super(DayTrackerInitialState()) {
    on<DayTrackerInitialEvent>(_onInitial);
    on<DayTrackerChangeEvent>(_onChange);
  }

  FutureOr<void> _onInitial(
      DayTrackerInitialEvent event, Emitter<DayTrackerState> emit) async {
    try {
      final habits = service.getHabits();
      await emit.forEach<List<Habit>>(habits,
          onData: (habits) => DayTrackerLoadedState(habits[index]));
    } catch (e) {
      emit(DayTrackerErrorState(e.toString()));
    }
  }

  FutureOr<void> _onChange(
      DayTrackerChangeEvent event, Emitter<DayTrackerState> emit) {}
}
