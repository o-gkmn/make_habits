import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_storage_habits_api/local_storage_habits_api.dart';
import 'package:make_habits/bootstap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final habitsApi =
      LocalStorageHabitsApi(plugin: await SharedPreferences.getInstance());

  bootstrap(habitsApi: habitsApi);
}
