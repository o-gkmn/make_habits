import 'dart:async';
import 'package:intl/intl.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:make_habits/assets/headings.dart';
import 'package:make_habits/modals/habits_model.dart';
import 'package:make_habits/services/services.dart';

part 'adding_screen_event.dart';
part 'adding_screen_state.dart';

class AddingScreenBloc extends Bloc<AddingScreenEvent, AddingScreenState> {
  Services habitServices;

  AddingScreenBloc(this.habitServices) : super(AddingScreenInitialState()) {
    on<AddingScreenInitialEvent>(_onInitialEvent);
    on<AddingScreenLoadingEvent>(_onLoadingEvent);
    on<AddingScreenLoadedEvent>(_onLoadedEvent);
    on<AddingScreenErrorEvent>(_onErrorEvent);
    on<AddingScreenSaveEvent>(_onSaveEvent);
  }

  FutureOr<void> _onInitialEvent(
      AddingScreenInitialEvent event, Emitter<AddingScreenState> emit) {
    emit(AddingScreenLoadingState());
    try {
      emit(AddingScreenLoadedState());
    } catch (e) {
      emit(const AddingScreenErrorState(Status.unexpectedError));
    }
  }

  FutureOr<void> _onLoadingEvent(
      AddingScreenLoadingEvent event, Emitter<AddingScreenState> emit) {}

  FutureOr<void> _onLoadedEvent(
      AddingScreenLoadedEvent event, Emitter<AddingScreenState> emit) {
    emit(AddingScreenLoadedState());
  }

  FutureOr<void> _onErrorEvent(
      AddingScreenErrorEvent event, Emitter<AddingScreenState> emit) {}

  FutureOr<void> _onSaveEvent(
      AddingScreenSaveEvent event, Emitter<AddingScreenState> emit) async {
    String firstDate =
        "${event.firstDay}.${event.firstMonth}.${event.firstYear}";
    String lastDate = "${event.lastDay}.${event.lastMonth}.${event.lastYear}";

    late DateTime formatFirstDate;
    late DateTime formatLastDate;

    formatFirstDate = DateFormat("dd.MM.yyyy").parse(firstDate);
    formatLastDate = DateFormat("dd.MM.yyyy").parse(lastDate);

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
    emit(AddingScreenLoadedState());

    int lastId;
    Map<String, bool> days = {};

    for (int i = 0; i < dayCount; ++i) {
      String date = DateFormat('dd.MM.yyyy')
          .format(formatFirstDate.add(Duration(days: i)));
      days[date] = false;
    }
    List<HabitsModel> habits =
        await habitServices.getData() as List<HabitsModel>;

    if (habits.isEmpty) {
      lastId = -1;
    } else {
      lastId = habits.last.id;
    }
    HabitsModel newData = HabitsModel(
        lastId + 1, dayCount, event.name, false, firstDate, lastDate, days);
    habitServices.addData(newData);
    emit(const AddingScreenErrorState(Status.succes));
  }
}
