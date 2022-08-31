import 'package:habits_api/habits_api.dart';

class HabitRepository {
  const HabitRepository({required HabitsApi habitsApi})
      : _habitsApi = habitsApi;

  final HabitsApi _habitsApi;

  Stream<List<Habit>> getHabits() => _habitsApi.getHabits();

  Future<void> saveHabits(Habit habit) => _habitsApi.saveHabit(habit);

  Future<void> deleteHabits(int id) => _habitsApi.deleteHabit(id);

  Future<void> clearAll() => _habitsApi.clearAll();

  Future<void> setId() => _habitsApi.setId();

  int lastId() => _habitsApi.lastId();

  Future<void> clearAllDeactive() => _habitsApi.clearAllDeactive();
}
