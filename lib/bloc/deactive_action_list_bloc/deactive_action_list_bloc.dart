import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_repository/habit_repository.dart';

part 'deactive_action_list_event.dart';
part 'deactive_action_list_state.dart';

class DeactiveActionListBloc
    extends Bloc<DeactiveActionListEvent, DeactiveActionListState> {
  HabitRepository services;

  DeactiveActionListBloc(this.services) : super(DeactiveActionListLoadState()) {
    on<DeactiveActionListLoadEvent>(_onLoadHabits);
    on<DeactiveActionListDeleteEvent>(_onDeleteEvent);
    on<DeactiveActionListClearAllEvent>(_onClearAll);
  }

  void _onLoadHabits(DeactiveActionListLoadEvent event,
      Emitter<DeactiveActionListState> emit) async {
    emit(DeactiveActionListLoadingState());
    try {
      final habitsList = services.getHabits();
      List<Habit> succedhabitList = [];
      await emit.forEach<List<Habit>>(habitsList, onData: (habits) {
        for (var element in habits) {
          if (element.didUserSucced == true) {
            succedhabitList.add(element);
          }
        }
        return DeactiveActionListLoadedState(succedhabitList);
      });
    } catch (e) {
      emit(DeactiveActionListErrorState(e.toString()));
    }
  }

  void _onDeleteEvent(DeactiveActionListDeleteEvent event,
      Emitter<DeactiveActionListState> emit) async {
    await services.deleteHabits(event.habit.id);
    await services.setId();
    add(DeactiveActionListLoadEvent());
  }

  FutureOr<void> _onClearAll(DeactiveActionListClearAllEvent event,
      Emitter<DeactiveActionListState> emit) async {
    await services.clearAllDeactive();
  }
}
