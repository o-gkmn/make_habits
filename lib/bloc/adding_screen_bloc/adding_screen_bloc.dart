import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:intl/intl.dart';

import 'package:bloc/bloc.dart';
import 'package:make_habits/assets/headings.dart';

part 'adding_screen_event.dart';
part 'adding_screen_state.dart';

class AddingScreenBloc extends Bloc<AddingScreenEvent, AddingScreenState> {
  HabitRepository services;

  AddingScreenBloc(this.services) : super(AddingScreenInitialState()) {
    on<AddingScreenInitialEvent>(_onInitialEvent);
    on<AddingScreenErrorEvent>(_onErrorEvent);
    on<AddingScreenSaveEvent>(_onSaveEvent);
  }

  FutureOr<void> _onInitialEvent(
      AddingScreenInitialEvent event, Emitter<AddingScreenState> emit) async {
    final habits = services.getHabits();
    try {
      await emit.forEach<List<Habit>>(habits,
          onData: (habits) => AddingScreenLoadedState(habits));
    } catch (e) {
      emit(const AddingScreenErrorState(Status.unexpectedError));
    }
  }

  FutureOr<void> _onErrorEvent(
      AddingScreenErrorEvent event, Emitter<AddingScreenState> emit) {
    return emit.forEach<List<Habit>>(services.getHabits(),
        onData: (data) => AddingScreenLoadedState(data));
  }

  FutureOr<void> _onSaveEvent(
      AddingScreenSaveEvent event, Emitter<AddingScreenState> emit) async {
    final String firstDate =
        "${event.firstDay}.${event.firstMonth}.${event.firstYear}";

    final String lastDate =
        "${event.lastDay}.${event.lastMonth}.${event.lastYear}";

    DateTime formatFirstDate = DateFormat("dd.MM.yyyy").parse(firstDate);
    DateTime formatLastDate = DateFormat("dd.MM.yyyy").parse(lastDate);

    int dayCount = formatLastDate.difference(formatFirstDate).inDays;

    if (formatFirstDate.isAfter(formatLastDate)) {
      emit(const AddingScreenErrorState(Status.dateError));
      throw Exception();
    }
    if (event.name.isEmpty) {
      emit(const AddingScreenErrorState(Status.nameError));
      throw Exception();
    }
    if (dayCount < 3) {
      emit(const AddingScreenErrorState(Status.dayError));
      throw Exception();
    }

    Map<String, bool> days = {};

    for (int i = 0; i <= dayCount; ++i) {
      String date = DateFormat("dd.MM.yyyy")
          .format(formatFirstDate.add(Duration(days: i)));
      days[date] = false;
    }

    Habit habit = Habit(
        id: services.lastId() + 1,
        name: event.name,
        startDay: firstDate,
        endDay: lastDate,
        didUserSucced: false,
        daysCount: dayCount,
        days: days);
    await services.saveHabits(habit);
    emit(const AddingScreenErrorState(Status.succes));
  }
}
