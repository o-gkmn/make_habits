import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';

part 'action_list_event.dart';
part 'action_list_state.dart';

class ActionListBloc extends Bloc<ActionListEvent, ActionListState> {
  HabitRepository services;

  ActionListBloc(this.services) : super(ActionListLoadState()) {
    on<ActionListLoadEvent>(_onLoadHabits);
    on<ActionListDeleteEvent>(_onDeleteEvent);
    on<ActionListClearAllEvent>(_onClearAll);
  }

  void _onLoadHabits(
      ActionListLoadEvent event, Emitter<ActionListState> emit) async {
    emit(ActionListLoadingState());
    try {
      final habitsList = services.getHabits();
      List<Habit> unSuccededHabitList = [];
      await emit.forEach<List<Habit>>(habitsList, onData: (habits) {
        for (var element in habits) {
          if (!element.didUserSucced) {
            unSuccededHabitList.add(element);
          }
        }
        return ActionListLoadedState(unSuccededHabitList);
      });
    } catch (e) {
      emit(ActionListErrorState(e.toString()));
    }
  }

  void _onDeleteEvent(
      ActionListDeleteEvent event, Emitter<ActionListState> emit) async {
    await services.deleteHabits(event.habit.id);
    await services.setId();
    add(ActionListLoadEvent());
  }

  FutureOr<void> _onClearAll(
      ActionListClearAllEvent event, Emitter<ActionListState> emit) async {
    await services.clearAll();
  }
}
