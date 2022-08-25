library habits_api;

import 'package:habits_api/habits_api.dart';

abstract class HabitsApi {
  const HabitsApi();

  Stream<List<Habit>> getHabits();

  Future<void> saveHabit(Habit habit);

  Future<void> deleteHabit(int id);

  Future<void> clearAll();

  Future<void> setId();

  int lastId();
}

class HabitNotFoundExceptions implements Exception {}
