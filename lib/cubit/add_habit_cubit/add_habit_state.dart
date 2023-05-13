part of 'add_habit_cubit.dart';

enum AddHabitStatus { initial, loading, loaded, error, added }

class AddHabitState extends Equatable {
  const AddHabitState(
      {required this.status, this.habit = const Habit.blank(), this.exception});

  final AddHabitStatus status;
  final Habit habit;
  final Exception? exception;

  AddHabitState copyWith(
          {AddHabitStatus? status, Habit? habit, Exception? exception}) =>
      AddHabitState(
          status: status ?? this.status,
          habit: habit ?? this.habit,
          exception: exception ?? this.exception);

  @override
  List<Object> get props => [status, habit];
}
