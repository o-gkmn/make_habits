part of 'deactive_action_list_bloc.dart';

abstract class DeactiveActionListEvent extends Equatable {
  const DeactiveActionListEvent();

  @override
  List<Object> get props => [];
}

class DeactiveActionListLoadEvent extends DeactiveActionListEvent {}

class DeactiveActionListDeleteEvent extends DeactiveActionListEvent {
  final Habit habit;

  const DeactiveActionListDeleteEvent(this.habit);

  @override
  List<Object> get props => [habit];
}

class DeactiveActionListClearAllEvent extends DeactiveActionListEvent {}
