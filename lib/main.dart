import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_theme/json_theme.dart';
import 'package:make_habits/bloc/adding_screen_bloc/adding_screen_bloc.dart';
import 'package:make_habits/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:make_habits/screens/action_list_screen.dart';
import 'package:make_habits/screens/adding_screen.dart';
import 'package:make_habits/screens/main_screen.dart';
import 'package:make_habits/services/habit_service.dart';

void main() async {
  WidgetsFlutterBinding();
  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  final HabitService service = HabitService();
  runApp(App(theme: theme, service: service));
}

class App extends StatelessWidget {
  final ThemeData theme;
  final HabitService _habitService;

  const App({super.key, required this.theme, required HabitService service})
      : _habitService = service;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _habitService,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (BuildContext context) =>
                    MainScreenBloc(_habitService)),
            BlocProvider(
                create: (BuildContext context) =>
                    AddingScreenBloc(_habitService)),
            BlocProvider(
                create: (BuildContext context) =>
                    AddingScreenBloc(_habitService))
          ],
          child: AppView(theme: theme),
        ));
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
        "/": (context) => BlocProvider(
            create: (context) =>
                MainScreenBloc(RepositoryProvider.of<HabitService>(context))
                  ..add(MainScreenInitialEvent()),
            child: const MainScreen()),
        "/List": (context) => const ActionListScreen(),
        "/Adding": (context) => const AddingScreen(),
      },
      initialRoute: "/",
    );
  }
}
