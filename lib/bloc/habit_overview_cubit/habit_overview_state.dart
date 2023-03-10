part of 'habit_overview_cubit.dart';

enum HabitOverviewStatus { initial, loading, loaded, error }

class HabitOverviewState extends Equatable {
  const HabitOverviewState({
    required this.habitOverviewStatus,
    this.habit = const Habit.empty(),
    this.exception,
  });

  final HabitOverviewStatus habitOverviewStatus;
  final Habit habit;
  final Exception? exception;

  HabitOverviewState copyWith({
    HabitOverviewStatus? habitOverviewStatus,
    Habit? habit,
    Exception? exception,
  }) {
    return HabitOverviewState(
      habitOverviewStatus: habitOverviewStatus ?? this.habitOverviewStatus,
      habit: habit ?? this.habit,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object> get props => [habitOverviewStatus, habit];
}
