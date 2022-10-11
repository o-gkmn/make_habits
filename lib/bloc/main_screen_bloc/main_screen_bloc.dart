import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:make_habits/bloc/main_screen_bloc/models/widgets_values.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  HabitRepository service;

  String todayString = "NaN";
  String tommorowString = "NaN";
  String yesterdayString = "NaN";

  bool todayBool = false;
  bool tommorowBool = false;
  bool yesterdayBool = false;

  double percent = 0.0;

  MainScreenBloc(this.service) : super(MainScreenInitialState()) {
    on<MainScreenInitialEvent>(_onMainScreenInitialEvent);
    on<MainScreenLoadingEvent>(_onMainScreenLoadingEvent);
    on<MainScreenCheckEvent>(_onMainScreenCheckEvent);
  }

  void _onMainScreenInitialEvent(
      MainScreenInitialEvent event, Emitter<MainScreenState> emit) async {
    final habitList = service.getHabits();
    await habitList.forEach((element) {
      try {
        if (element.isEmpty) {
          WidgetValues widgetValues = const WidgetValues.empty();
          emit(MainScreenCheckBoxState(
              habit_: const Habit.empty(), widgetValues_: widgetValues));
        } else {
          add(MainScreenLoadingEvent(element, index: event.index));
        }
      } catch (e) {
        emit(MainScreenErrorState(e.toString()));
      }
    });
  }

  void _onMainScreenLoadingEvent(
      MainScreenLoadingEvent event, Emitter<MainScreenState> emit) {
    WidgetValues widgetValues = const WidgetValues.empty();
    DateTime today = DateTime.now();
    String todayFormat = DateFormat('dd.MM.yyyy').format(today);

    var keys = event.habits[event.index].days.keys;
    var values = event.habits[event.index].days.values;

    int trueValues = 0;
    for (int i = 0; i < keys.length; ++i) {
      if (todayFormat == keys.elementAt(i)) {
        todayString = keys.elementAt(i);
        todayBool = values.elementAt(i);

        if (i - 1 >= 0) {
          yesterdayString = keys.elementAt(i - 1);
          yesterdayBool = values.elementAt(i - 1);
        } else {
          yesterdayString = "Gün yok";
          yesterdayBool = false;
        }

        if (i + 1 < keys.length) {
          tommorowString = keys.elementAt(i + 1);
          tommorowBool = values.elementAt(i + 1);
        } else {
          tommorowString = "Gün yok";
          tommorowBool = false;
        }
        break;
      } else {
        yesterdayString = "Gün yok";
        yesterdayBool = false;
        todayString = "Gün yok";
        todayBool = false;
        tommorowString = "Gün yok";
        tommorowBool = false;
      }
    }
    for (int i = 0; i < values.length; ++i) {
      if (values.elementAt(i) == true) {
        trueValues += 1;
      }
    }

    double percent = trueValues * 100 / values.length;
    widgetValues = widgetValues.copyWith(
        today: todayString,
        yesterday: yesterdayString,
        tommorow: tommorowString,
        todayBool: todayBool,
        yesterdayBool: yesterdayBool,
        tommorowBool: tommorowBool,
        percent: percent);

    emit(MainScreenCheckBoxState(
        habit_: event.habits[event.index], widgetValues_: widgetValues));
  }

  FutureOr<void> _onMainScreenCheckEvent(
      MainScreenCheckEvent event, Emitter<MainScreenState> emit) async {
    for (String day in event.habit.days.keys) {
      if (day == event.dayString) {
        event.habit.days[event.dayString] = event.checkBoxStatus;
      }
    }

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
