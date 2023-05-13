import 'package:flutter/material.dart';
import 'package:make_habits/bootstap.dart';
import 'package:sqflite_manager/sqflite_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final habitsApi = SqfliteManager();

  bootstrap(habitsApi: habitsApi);
}
