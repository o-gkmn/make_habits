import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:make_habits/screens/action_list_screen.dart';
import 'package:make_habits/screens/adding_screen.dart';
import 'package:make_habits/screens/day_tracker_screen.dart';
import 'package:make_habits/screens/deactive_action_list.dart';
import 'package:make_habits/screens/main_screen.dart';
import 'package:make_habits/theme/app_theme.dart';

class App extends StatelessWidget {
  final HabitRepository habitRepository;

  const App({super.key, required this.habitRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: habitRepository, child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const MainScreen(),
        "/List": (context) => const ActionListScreen(),
        "/Adding": (context) => const AddingScreen(),
        "/DayTracker": (context) => const DayTrackerScreen(),
        "/DeactiveList": (context) => const DeactiveActionListScreen()
      },
      theme: YellowTheme().lightTheme,
      initialRoute: "/",
    );
  }
}
