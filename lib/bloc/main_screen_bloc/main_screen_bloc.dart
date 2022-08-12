import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:make_habits/modals/habits_model.dart';
import 'package:make_habits/services/habit_service.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  HabitService service;

  MainScreenBloc(this.service) : super(MainScreenInitialState()) {
    on<MainScreenInitialEvent>(_onMainScreenInitialEvent);
    on<MainScreenLoadingEvent>(_onMainScreenLoadingEvent);
    on<MainScreenLoadedEvent>(_onMainScreenLoadedEvent);
    on<MainScreenErrorEvent>(_onMainScreenErrorEvent);
    on<MainScreenCheckBoxEvent>(_onMainScrenCheckBoxEvent);
  }

  void _onMainScreenInitialEvent(
      MainScreenInitialEvent event, Emitter<MainScreenState> emit) async {
    emit(MainScreenLoadingState());
    try {
      final habitList = await service.getData();
      if (habitList.isEmpty) {
        emit(const MainScreenCheckBoxState(
            "--", "--", "--", false, false, false, 0));
      } else {
        emit(MainScreenLoadedState(habitList));
      }
    } catch (e) {
      emit(MainScreenErrorState(e.toString()));
    }
  }

  void _onMainScreenLoadingEvent(
      MainScreenLoadingEvent event, Emitter<MainScreenState> emit) {}

  void _onMainScreenLoadedEvent(
      MainScreenLoadedEvent event, Emitter<MainScreenState> emit) {
    DateTime today = DateTime.now();
    DateTime yesterday = DateTime.utc(today.year, today.month, today.day - 1);
    DateTime tommorow = DateTime.utc(today.year, today.month, today.day + 1);

    String todayFormat = DateFormat('dd.MM.yyyy').format(today);
    String yesterdayFormat = DateFormat('dd.MM.yyyy').format(yesterday);
    String tommorowFormat = DateFormat('dd.MM.yyyy').format(tommorow);

    String todayString = "";
    String tommorowString = "";
    String yesterdayString = "";

    bool todayBool = false;
    bool tommorowBool = false;
    bool yesterdayBool = false;

    var keys = event.habits[event.index].days.keys;
    var values = event.habits[event.index].days.values;

    int trueValues = 0;
    for (int i = 0; i < keys.length; ++i) {
      if (todayFormat == keys.elementAt(i)) {
        todayString = keys.elementAt(i);
        todayBool = values.elementAt(i);

        if (i - 1 >= 0 && yesterdayFormat == keys.elementAt(i - 1)) {
          yesterdayString = keys.elementAt(i - 1);
          yesterdayBool = values.elementAt(i - 1);
        } else {
          yesterdayString = "---";
          yesterdayBool = false;
        }

        if (i + 1 < keys.length && tommorowFormat == keys.elementAt(i + 1)) {
          tommorowString = keys.elementAt(i + 1);
          tommorowBool = values.elementAt(i + 1);
        } else {
          tommorowString = "---";
          tommorowBool = false;
        }
        break;
      } else {
        yesterdayString = keys.elementAt(0);
        yesterdayBool = values.elementAt(0);
        todayString = keys.elementAt(1);
        todayBool = values.elementAt(1);
        tommorowString = keys.elementAt(2);
        tommorowBool = values.elementAt(2);
      }
    }

    for (int i = 0; i < values.length; ++i) {
      if (values.elementAt(i) == true) {
        trueValues += 1;
      }
    }

    double percent = trueValues * 100 / values.length;

    emit(MainScreenCheckBoxState(todayString, tommorowString, yesterdayString,
        todayBool, tommorowBool, yesterdayBool, percent));
  }

  void _onMainScreenErrorEvent(
      MainScreenErrorEvent event, Emitter<MainScreenState> emit) {}

  void _onMainScrenCheckBoxEvent(
      MainScreenCheckBoxEvent event, Emitter<MainScreenState> emit) {}
}
