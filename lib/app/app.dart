import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:make_habits/screens/action_list_screen.dart';
import 'package:make_habits/screens/adding_screen.dart';
import 'package:make_habits/screens/day_tracker_screen.dart';
import 'package:make_habits/screens/main_screen.dart';

class App extends StatelessWidget {
  final ThemeData theme;
  final HabitRepository habitRepository;

  const App({super.key, required this.theme, required this.habitRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: habitRepository, child: AppView(theme: theme));
  }
}

class AppView extends StatelessWidget {
  final ThemeData theme;

  const AppView({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: {
        "/": (context) => const MainScreen(),
        "/List": (context) => const ActionListScreen(),
        "/Adding": (context) => const AddingScreen(),
        "/DayTracker": (context) => const DayTrackerScreen(),
      },
      initialRoute: "/",
    );
  }
}
