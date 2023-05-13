library habits_api;

import 'models/models.dart';

abstract class HabitsApi {
  const HabitsApi();

  Future<List<Habit>> getHabits();

  Future<void> insertHabit(Habit habit);

  Future<void> deleteHabit(int id);

  Future<void> updateHabitAttribute(HabitAttribute habitAttribute);

  Future<void> updateHabitDate(Date date);

  Future<void> clearHabits();

  Future<void> clearDeactiveHabits();
}

class HabitNotFoundExceptions implements Exception {}
