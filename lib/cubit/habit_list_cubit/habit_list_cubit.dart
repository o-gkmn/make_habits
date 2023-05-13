import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habits_api/models/models.dart';

part 'habit_list_state.dart';

class HabitListCubit extends Cubit<HabitListState> {
  final HabitRepository _habitRepository;

  HabitListCubit({required HabitRepository habitRepository})
      : _habitRepository = habitRepository,
        super(const HabitListState(status: HabitListStatus.initial));

  void loadHabitList() async {
    emit(state.copyWith(status: HabitListStatus.loading));

    try {
      final habitList = await _habitRepository.getHabits();
      emit(state.copyWith(status: HabitListStatus.loaded, habits: habitList));
    } catch (e) {
      emit(state.copyWith(exception: e as Exception));
    }
  }

  void deleteHabit(int id) async {
    try {
      await _habitRepository.deleteHabit(id);
    } catch (e) {
      emit(state.copyWith(exception: e as Exception));
    }
    loadHabitList();
  }

  void clearAll() async {
    try {
      await _habitRepository.clearHabits();
    } catch (e) {
      emit(state.copyWith(exception: e as Exception));
    }
    loadHabitList();
  }
}
