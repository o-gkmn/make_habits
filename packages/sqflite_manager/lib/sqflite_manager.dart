import 'dart:async';
import 'package:habits_api/habits_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_constants.dart';

class SqfliteManager extends HabitsApi {
  Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), dbName);
    Database habitsTrackerDb =
        await openDatabase(dbPath, version: 1, onCreate: createTable);
    return habitsTrackerDb;
  }

  FutureOr<void> createTable(Database db, int version) {
    db.rawQuery(
        "CREATE TABLE $habitsTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $startDate TEXT, $dueDate TEXT, $didUserSucced INTEGER)");
  }

  @override
  Future<void> clearDeactiveHabits() async {
    Database? db = await this.db;
    await db!.rawDelete("DELETE FROM $habitsTable WHERE $didUserSucced=1");
  }

  @override
  Future<void> clearHabits() async {
    Database? db = await this.db;
    await db!.rawDelete("DELETE FROM $habitsTable");
  }

  @override
  Future<void> deleteHabit(int id) async {
    Database? db = await this.db;
    await db!.rawDelete("DELETE FROM $habitsTable WHERE $id=?", [id]);
  }

  @override
  Future<List<Habit>> getHabits() async {
    Database? db = await this.db;
    final habitMap = await db!.rawQuery("SELECT * FROM $habitsTable");

    return List.generate(
      habitMap.length,
      (index) => Habit.fromJson(
        habitMap.elementAt(index),
      ),
    );
  }

  @override
  Future<void> insertHabit(Habit habit) async {
    Database? db = await this.db;
    final jsonHabit = habit.toJson();
    db!.rawInsert(
        "INSERT INTO $habitsTable($name, $startDate, $dueDate, $didUserSucced, $completedDates) VALUES(?, ?, ?, ?, ?)",
        [
          jsonHabit[name],
          jsonHabit[startDate],
          jsonHabit[dueDate],
          jsonHabit[didUserSucced],
          jsonHabit[completedDates]
        ]);
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    Database? db = await this.db;
    final jsonHabit = habit.toJson();

    db!.rawUpdate(
      "UPDATE $habitsTable SET $name = ?, $startDate = ?, $dueDate = ?, $didUserSucced = ? , $completedDates = ? WHERE id=?",
      [
        jsonHabit[name],
        jsonHabit[startDate],
        jsonHabit[dueDate],
        jsonHabit[didUserSucced],
        jsonHabit[completedDates],
        jsonHabit[id],
      ],
    );
  }
}
