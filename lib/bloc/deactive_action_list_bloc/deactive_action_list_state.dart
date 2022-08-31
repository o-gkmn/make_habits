part of 'deactive_action_list_bloc.dart';

abstract class DeactiveActionListState extends Equatable {
  final List<Habit> habits;

  const DeactiveActionListState({this.habits = const []});

  @override
  List<Object> get props => [habits];
}

class DeactiveActionListLoadState extends DeactiveActionListState {}

class DeactiveActionListLoadingState extends DeactiveActionListState {}

class DeactiveActionListLoadedState extends DeactiveActionListState {
  final List<Habit> habitList;

  const DeactiveActionListLoadedState(this.habitList)
      : super(habits: habitList);

  @override
  List<Object> get props => [habitList];
}

class DeactiveActionListErrorState extends DeactiveActionListState {
  final String errorMsg;

  const DeactiveActionListErrorState(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
