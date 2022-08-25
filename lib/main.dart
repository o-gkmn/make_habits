import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:local_storage_habits_api/local_storage_habits_api.dart';
import 'package:make_habits/bootstap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  final habitsApi =
      LocalStorageHabitsApi(plugin: await SharedPreferences.getInstance());

  bootstrap(theme: theme, habitsApi: habitsApi);
}
