import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habits_api/models/models.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit({required HabitRepository habitRepository})
      : _habitRepository = habitRepository,
        super(MainScreenState(status: MainStatus.initial));

  final HabitRepository _habitRepository;

  void goToTab(int page, {Habit? habit}) {
    state.controller.jumpToPage(page);
    if (habit != null) {
      final completionRatio = calculateCompletionRate(habit);
      emit(state.copyWith(
          currentPage: page, completionRatio: completionRatio, habit: habit));
    } else {
      emit(state.copyWith(currentPage: page));
    }
  }

  void animateToTab(int page) {
    state.controller.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    emit(state.copyWith(currentPage: page));
  }

  double calculateCompletionRate(Habit habit) {
    final completedDates =
        habit.dates.where((element) => element.isDone).toList();

    return completedDates.length / habit.dates.length;
  }

  void switchCheckBox(int index, bool value) async {
    var dateList = [...state.habit.dates];
    dateList[index] = dateList[index].copyWith(isDone: value);

    final updatedHabit = state.habit.copyWith(dates: dateList);
    final completionRatio = calculateCompletionRate(updatedHabit);
    emit(state.copyWith(habit: updatedHabit, completionRatio: completionRatio));

    try {
      await _habitRepository
          .updateHabitDate(state.habit.dates[index].copyWith(isDone: value));
    } on Exception catch (e) {
      emit(state.copyWith(status: MainStatus.error, exception: e));
    }
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
