part of 'action_list_bloc.dart';

abstract class ActionListEvent extends Equatable {
  const ActionListEvent();

  @override
  List<Object> get props => [];
}

class ActionListLoadEvent extends ActionListEvent {}

class ActionListDeleteEvent extends ActionListEvent {
  final int id;

  const ActionListDeleteEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ActionListClearAllEvent extends ActionListEvent {}
