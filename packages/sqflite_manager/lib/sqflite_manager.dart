import 'dart:async';
import 'package:habits_api/habits_api.dart';
import 'package:habits_api/models/models.dart';
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
    Database habitsTrackerDb = await openDatabase(dbPath,
        version: 1, onCreate: createTable, onConfigure: onConfigure);
    return habitsTrackerDb;
  }

  FutureOr<void> createTable(Database db, int version) async {
    await db.rawQuery(
        "CREATE TABLE ${Tables.habit}(${HabitFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${HabitFields.title} TEXT, ${HabitFields.startDate} TEXT, ${HabitFields.dueTime} TEXT, ${HabitFields.isActive} TEXT, ${HabitFields.howLongItWillTake} INTEGER)");
    await db.rawQuery(
        "CREATE TABLE ${Tables.dates}(${DateFields.dateId} INTEGER PRIMARY KEY AUTOINCREMENT, ${DateFields.id} INTEGER, ${DateFields.date} TEXT, ${DateFields.isDone} INTEGER)");
  }

  static Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  @override
  Future<void> clearDeactiveHabits() async {
    Database? db = await this.db;
    await db!.rawDelete(
        "DELETE FROM ${Tables.dates} WHERE ${DateFields.id} IN (SELECT ${HabitFields.id} FROM ${Tables.habit} WHERE ${HabitFields.isActive}=0)");
    await db.rawDelete(
        "DELETE FROM ${Tables.habit} WHERE ${HabitFields.isActive}=0");
  }

  @override
  Future<void> clearHabits() async {
    Database? db = await this.db;
    await db!.rawDelete("DELETE FROM ${Tables.habit}");
    await db.rawDelete("DELETE FROM ${Tables.dates}");
  }

  @override
  Future<void> deleteHabit(int id) async {
    Database? db = await this.db;
    await db!.rawDelete(
        "DELETE FROM ${Tables.habit} WHERE ${HabitFields.id}=?", [id]);
    await db.rawDelete(
        "DELETE FROM ${Tables.dates} WHERE ${DateFields.id}=?", [id]);
  }

  @override
  Future<List<Habit>> getHabits() async {
    Database? db = await this.db;
    final habitAttributeMapList =
        await db!.rawQuery("SELECT * FROM ${Tables.habit}");
    final datesMap = await db.rawQuery("SELECT * FROM ${Tables.dates}");
    final habitList = <Habit>[];

    for (var habitAttributeMap in habitAttributeMapList) {
      final datesList = <Date>[];

      HabitAttribute habitAttribute =
          HabitAttribute.fromJson(habitAttributeMap);
      for (var date in datesMap) {
        if (date[DateFields.id] == habitAttribute.id) {
          datesList.add(Date.fromJson(date));
        }
      }
      habitList.add(Habit(habitAttribute: habitAttribute, dates: datesList));
    }

    return habitList;
  }

  @override
  Future<void> insertHabit(Habit habit) async {
    Database? db = await this.db;
    final jsonHabit = habit.habitAttribute.toJson();
    await db!.rawInsert(
        "INSERT INTO ${Tables.habit}(${HabitFields.title}, ${HabitFields.startDate}, ${HabitFields.dueTime}, ${HabitFields.isActive}, ${HabitFields.howLongItWillTake}) VALUES(?, ?, ?, ?, ?)",
        [
          jsonHabit[HabitFields.title],
          jsonHabit[HabitFields.startDate],
          jsonHabit[HabitFields.dueTime],
          jsonHabit[HabitFields.isActive],
          jsonHabit[HabitFields.howLongItWillTake]
        ]);

    final lastItem = await db.rawQuery(
        "SELECT * FROM ${Tables.habit} ORDER BY ${HabitFields.id} DESC LIMIT 1");

    for (var element in habit.dates) {
      final jsonDates = element.toJson();
      await db.rawInsert(
        "INSERT INTO ${Tables.dates}(${DateFields.id}, ${DateFields.date}, ${DateFields.isDone}) VALUES(?, ?, ?)",
        [
          lastItem.first[HabitFields.id],
          jsonDates[DateFields.date],
          jsonDates[DateFields.isDone],
        ],
      );
    }
  }

  @override
  Future<void> updateHabitAttribute(HabitAttribute habitAttribute) async {
    Database? db = await this.db;
    final jsonHabitAttribute = habitAttribute.toJson();

    await db!.rawUpdate(
      "UPDATE ${Tables.habit} SET ${HabitFields.title} = ?, ${HabitFields.startDate} = ?, ${HabitFields.dueTime} = ?, ${HabitFields.isActive} = ? , ${HabitFields.howLongItWillTake} = ? WHERE id=?",
      [
        jsonHabitAttribute[HabitFields.title],
        jsonHabitAttribute[HabitFields.startDate],
        jsonHabitAttribute[HabitFields.dueTime],
        jsonHabitAttribute[HabitFields.isActive],
        jsonHabitAttribute[HabitFields.howLongItWillTake],
        jsonHabitAttribute[HabitFields.id],
      ],
    );
  }

  @override
  Future<void> updateHabitDate(Date date) async {
    Database? db = await this.db;
    final jsonDate = date.toJson();

    await db!.rawUpdate(
      "UPDATE ${Tables.dates} SET ${DateFields.id} = ?, ${DateFields.date} = ?, ${DateFields.isDone} = ? WHERE dateId = ?",
      [
        jsonDate[DateFields.id],
        jsonDate[DateFields.date],
        jsonDate[DateFields.isDone],
        jsonDate[DateFields.dateId]
      ],
    );
  }
}
