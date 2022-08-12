part of 'action_list_bloc.dart';

abstract class ActionListState extends Equatable {
  const ActionListState();

  @override
  List<Object> get props => [];
}

class ActionListLoadState extends ActionListState {}

class ActionListLoadingState extends ActionListState {}

class ActionListLoadedState extends ActionListState {
  final List<HabitsModel> habits;

  const ActionListLoadedState(this.habits);

  @override
  List<Object> get props => [habits];
}

class ActionListErrorState extends ActionListState {
  final String errorMsg;

  const ActionListErrorState(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
