import 'package:flutter/material.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habits_api/habits_api.dart';
import 'package:make_habits/app/app.dart';

void bootstrap({required HabitsApi habitsApi}) {
  final habitsRepository = HabitRepository(habitsApi: habitsApi);

  runApp(App(habitRepository: habitsRepository));
}
