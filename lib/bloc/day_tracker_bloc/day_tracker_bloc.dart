// ignore_for_file: depend_on_referenced_packages

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
      DayTrackerChangeEvent event, Emitter<DayTrackerState> emit) async {
    if (event.habit.days.containsKey(event.dayString)) {
      int trueValues = 0;
      for (int i = 0; i < event.habit.days.values.length; ++i) {
        if (event.habit.days.values.elementAt(i) == true) {
          trueValues += 1;
        }
      }

      Habit habit;
      double percent = trueValues * 100 / event.habit.days.values.length;
      if (percent == 100.0) {
        habit = event.habit.copyWith(
            percent: percent, days: event.habit.days, didUserSucced: true);
      } else {
        habit = event.habit.copyWith(
            percent: percent, days: event.habit.days, didUserSucced: false);
      }
      await service.saveHabits(habit);
    }
  }
}
