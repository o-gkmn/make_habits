import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:make_habits/modals/habits_model.dart';
import 'package:make_habits/services/habit_service.dart';

part 'day_tracker_event.dart';
part 'day_tracker_state.dart';

class DayTrackerBloc extends Bloc<DayTrackerEvent, DayTrackerState> {
  int index;
  HabitService service;

  DayTrackerBloc(this.service, this.index) : super(DayTrackerInitialState()) {
    on<DayTrackerInitialEvent>(_onInitial);
    on<DayTrackerLoadingEvent>(_onLoading);
    on<DayTrackerLoadedEvent>(_onLoaded);
    on<DayTrackerErrorEvent>(_onError);
    on<DayTrackerChangeEvent>(_onChange);
  }

  FutureOr<void> _onInitial(
      DayTrackerInitialEvent event, Emitter<DayTrackerState> emit) async {
    try {
      List<HabitsModel> habits = await service.getData();
      add(DayTrackerLoadedEvent(habits));
    } catch (e) {
      emit(DayTrackerErrorState(e.toString()));
    }
  }

  FutureOr<void> _onLoading(
      DayTrackerLoadingEvent event, Emitter<DayTrackerState> emit) {}

  FutureOr<void> _onLoaded(
      DayTrackerLoadedEvent event, Emitter<DayTrackerState> emit) {
    HabitsModel habit = event.habits[index];
    emit(DayTrackerLoadedState(habit));
  }

  FutureOr<void> _onError(
      DayTrackerErrorEvent event, Emitter<DayTrackerState> emit) {}

  FutureOr<void> _onChange(
      DayTrackerChangeEvent event, Emitter<DayTrackerState> emit) {}
}
