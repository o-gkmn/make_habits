import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';

part 'habit_overview_state.dart';

class HabitOverviewCubit extends Cubit<HabitOverviewState> {
  HabitRepository _habitRepository;

  HabitOverviewCubit({required HabitRepository habitRepository})
      : _habitRepository = habitRepository,
        super(const HabitOverviewState(
          habitOverviewStatus: HabitOverviewStatus.initial,
        ));

  void loadOverviewScreen() async {
    emit(state.copyWith(habitOverviewStatus: HabitOverviewStatus.loading));
    //lsi
  }
}
