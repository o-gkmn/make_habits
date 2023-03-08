library habits_api;

import 'package:habits_api/habits_api.dart';

abstract class HabitsApi {
  const HabitsApi();

  Object getHabits();

  Future<void> insertHabit(Habit habit);

  Future<void> deleteHabit(int id);

  Future<void> updateHabit(Habit habit);

  Future<void> clearHabits();

  Future<void> clearDeactiveHabits();
}

class HabitNotFoundExceptions implements Exception {}
