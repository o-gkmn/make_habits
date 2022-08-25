part of 'action_list_bloc.dart';

abstract class ActionListState extends Equatable {
  const ActionListState({this.habits = const []});

  final List<Habit> habits;

  @override
  List<Object> get props => [habits];
}

class ActionListLoadState extends ActionListState {}

class ActionListLoadingState extends ActionListState {}

class ActionListLoadedState extends ActionListState {
  final List<Habit> habitsList;

  const ActionListLoadedState(this.habitsList) : super(habits: habitsList);

  @override
  List<Object> get props => [habitsList];
}

class ActionListErrorState extends ActionListState {
  final String errorMsg;

  const ActionListErrorState(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
