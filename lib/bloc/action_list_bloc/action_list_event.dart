part of 'action_list_bloc.dart';

abstract class ActionListEvent extends Equatable {
  const ActionListEvent();

  @override
  List<Object> get props => [];
}

class ActionListLoadEvent extends ActionListEvent {}

class ActionListDeleteEvent extends ActionListEvent {
  final Habit habit;

  const ActionListDeleteEvent(this.habit);

  @override
  List<Object> get props => [habit];
}

class ActionListClearAllEvent extends ActionListEvent {}
