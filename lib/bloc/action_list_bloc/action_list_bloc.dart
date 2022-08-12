import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_habits/modals/habits_model.dart';
import 'package:make_habits/services/habit_service.dart';

part 'action_list_event.dart';
part 'action_list_state.dart';

class ActionListBloc extends Bloc<ActionListEvent, ActionListState> {
  HabitService services;

  ActionListBloc(this.services) : super(ActionListLoadState()) {
    on<ActionListLoadEvent>(_onLoadHabits);
    on<ActionListLoadingEvent>(_onLoadingHabits);
    on<ActionListLoadedEvent>(_onLoadedHabits);
    on<ActionListErrorEvent>(_onErrorHabits);
  }

  void _onLoadHabits(
      ActionListLoadEvent event, Emitter<ActionListState> emit) async {
    emit(ActionListLoadingState());
    try {
      final habitsList = await services.getData();
      emit(ActionListLoadedState(habitsList));
    } catch (e) {
      emit(ActionListErrorState(e.toString()));
    }
  }

  void _onLoadingHabits(
      ActionListLoadingEvent event, Emitter<ActionListState> emit) {}

  void _onLoadedHabits(
      ActionListLoadedEvent event, Emitter<ActionListState> emit) {}

  void _onErrorHabits(
      ActionListErrorEvent event, Emitter<ActionListState> emit) {}
}
