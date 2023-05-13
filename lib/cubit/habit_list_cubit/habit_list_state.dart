part of 'habit_list_cubit.dart';

enum HabitListStatus { initial, loading, loaded, error }

class HabitListState extends Equatable {
  const HabitListState(
      {required this.status, this.habits = const [], this.exception});

  final HabitListStatus status;
  final List<Habit> habits;
  final Exception? exception;

  HabitListState copyWith(
          {HabitListStatus? status,
          List<Habit>? habits,
          Exception? exception}) =>
      HabitListState(
          status: status ?? this.status,
          habits: habits ?? this.habits,
          exception: exception ?? this.exception);

  @override
  List<Object> get props => [status, habits];
}
