import 'package:habits_api/habits_api.dart';
import 'package:habits_api/models/models.dart';

class HabitRepository {
  const HabitRepository({required HabitsApi habitsApi})
      : _habitsApi = habitsApi;

  final HabitsApi _habitsApi;

  Future<List<Habit>> getHabits() => _habitsApi.getHabits();

  Future<void> insertHabit(Habit habit) => _habitsApi.insertHabit(habit);

  Future<void> deleteHabit(int id) => _habitsApi.deleteHabit(id);

  Future<void> updateHabitAttribute(HabitAttribute habitAttribute) => _habitsApi.updateHabitAttribute(habitAttribute);

  Future<void> updateHabitDate(Date date) => _habitsApi.updateHabitDate(date);

  Future<void> clearHabits() => _habitsApi.clearHabits();

  Future<void> clearDeactiveHabits() => _habitsApi.clearDeactiveHabits();
}
