import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:habits_api/habits_api.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHabitsApi extends HabitsApi {
  LocalStorageHabitsApi({required SharedPreferences plugin})
      : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;
  final _habitStreamController = BehaviorSubject<List<Habit>>.seeded(const []);

  @visibleForTesting
  static const kHabitsCollectionKey = '__habits_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  _init() {
    final habitsJson = _getValue(kHabitsCollectionKey);
    if (habitsJson != null) {
      final habits = List<Map<dynamic, dynamic>>.from(
              json.decode(habitsJson) as List)
          .map((jsonMap) => Habit.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _habitStreamController.add(habits);
    } else {
      _habitStreamController.add([]);
    }
  }

  @override
  Stream<List<Habit>> getHabits() => _habitStreamController.asBroadcastStream();

  @override
  Future<void> saveHabit(Habit habit) {
    List<Habit> habits = [..._habitStreamController.value];
    final habitIndex = habits.indexWhere((element) => element.id == habit.id);
    if (habitIndex >= 0) {
      habits[habitIndex] = habit;
    } else {
      habits.add(habit);
    }
    _habitStreamController.add(habits);
    return _setValue(kHabitsCollectionKey, json.encode(habits));
  }

  @override
  Future<void> deleteHabit(int id) {
    List<Habit> habits = [..._habitStreamController.value];
    final habitIndex = habits.indexWhere((element) => element.id == id);
    if (habitIndex == -1) {
      throw HabitNotFoundExceptions();
    } else {
      habits.removeAt(id);
      _habitStreamController.add(habits);
      return _setValue(kHabitsCollectionKey, json.encode(habits));
    }
  }

  @override
  Future<void> setId() {
    List<Habit> habits = [..._habitStreamController.value];
    for (int i = 0; i < habits.length; ++i) {
      habits[i] = habits[i].copyWith(id: habits.indexOf(habits[i]));
    }
    _habitStreamController.add(habits);
    return _setValue(kHabitsCollectionKey, json.encode(habits));
  }

  @override
  int lastId() {
    List<Habit> habits = [..._habitStreamController.value];
    if (habits.isEmpty) return -1;
    return habits.indexOf(habits.last);
  }

  @override
  Future<void> clearAll() {
    final habits = [..._habitStreamController.value];
    habits.removeWhere((element) => !element.didUserSucced);
    _habitStreamController.add(habits);
    return _setValue(kHabitsCollectionKey, json.encode(habits));
  }

  @override
  Future<void> clearAllDeactive() {
    final habits = [..._habitStreamController.value];
    habits.removeWhere((element) => element.didUserSucced);
    _habitStreamController.add(habits);
    return _setValue(kHabitsCollectionKey, json.encode(habits));
  }
}
