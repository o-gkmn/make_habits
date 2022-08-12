part of 'action_list_bloc.dart';

abstract class ActionListEvent extends Equatable {
  const ActionListEvent();

  @override
  List<Object> get props => [];
}

class ActionListLoadEvent extends ActionListEvent {}

class ActionListLoadingEvent extends ActionListEvent {}

class ActionListLoadedEvent extends ActionListEvent {
  final List<HabitsModel> habits;

  const ActionListLoadedEvent(this.habits);

  @override
  List<Object> get props => [habits];
}

class ActionListErrorEvent extends ActionListEvent {
  final String errorMsg;

  const ActionListErrorEvent(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
