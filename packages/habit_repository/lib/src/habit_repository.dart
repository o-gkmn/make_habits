import 'package:habits_api/habits_api.dart';

class HabitRepository {
  const HabitRepository({required HabitsApi habitsApi})
      : _habitsApi = habitsApi;

  final HabitsApi _habitsApi;

  Object getHabits() => _habitsApi.getHabits();

  Future<void> insertHabit(Habit habit) => _habitsApi.insertHabit(habit);

  Future<void> deleteHabit(int id) => _habitsApi.deleteHabit(id);

  Future<void> updateHabit(Habit habit) => _habitsApi.updateHabit(habit);

  Future<void> clearHabits() => _habitsApi.clearHabits();

  Future<void> clearDeactiveHabits() => _habitsApi.clearDeactiveHabits();
}
