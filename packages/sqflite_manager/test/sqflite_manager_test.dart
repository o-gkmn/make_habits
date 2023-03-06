import 'package:flutter_test/flutter_test.dart';
import 'package:habits_api/habits_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_manager/db_constants.dart';

void main() {
  late Database database;
  Habit testHabit = const Habit(
      id: 1,
      name: "mock ",
      startDate: "06.03.2023",
      dueDate: "09.03.2023",
      didUserSucced: true,
      completedDates: ["06.03.2023", "07.03.2023"]);

  setUpAll(
    () async {
      sqfliteFfiInit();
      database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      database.rawQuery(
          "CREATE TABLE $habitsTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $startDate TEXT, $dueDate TEXT, $didUserSucced INTEGER, $completedDates BLOB)");

      final encodedHabit = testHabit.toJson();
      database.rawInsert(
          "INSERT INTO $habitsTable($name, $startDate, $dueDate, $didUserSucced, $completedDates) VALUES('${encodedHabit[name]}', '${encodedHabit[startDate]}', '${encodedHabit[dueDate]}', ${encodedHabit[didUserSucced]}, '${encodedHabit[completedDates]}')");
    },
  );

  group('Database Test', () {
    test('database opened succesfully', () {
      expect(database.isOpen, true);
    });

    test("sqflite version", () async {
      expect(await database.getVersion(), 0);
    });

    test("Insert data completed succesfully", () async {
      var beforeAdd = await database.query(habitsTable);
      final encodedHabit = testHabit.toJson();
      var afterAdd = await database.rawInsert(
          "INSERT INTO $habitsTable($name, $startDate, $dueDate, $didUserSucced, $completedDates) VALUES(?, ?, ?, ?, ?)",
          [
            encodedHabit[name],
            encodedHabit[startDate],
            encodedHabit[dueDate],
            encodedHabit[didUserSucced],
            encodedHabit[completedDates]
          ]);

      expect(afterAdd, beforeAdd.length + 1);
    });

    test('Get data completed succesfully', () async {
      final habitMap = await database.rawQuery("SELECT * FROM $habitsTable");

      var habitList = List.generate(
        habitMap.length,
        (index) => Habit.fromJson(
          habitMap.elementAt(index),
        ),
      );

      expect(habitList.length, 1);
    });

    test('Delete data with id is completed succesfully', () async {
      await database
          .rawDelete("DELETE FROM $habitsTable WHERE $id=?", [testHabit.id]);

      var afterDelete = await database.rawQuery("SELECT * FROM $habitsTable");
      expect(afterDelete.length, 0);
    });

    test('Update data is completed succesfully', () async {
      final encodedHabit = testHabit.copyWith(name: "lorem iipsum").toJson();

      database.rawUpdate(
        "UPDATE $habitsTable SET $name = ?, $startDate = ?, $dueDate = ?, $didUserSucced = ? , $completedDates = ? WHERE id=?",
        [
          encodedHabit[name],
          encodedHabit[startDate],
          encodedHabit[dueDate],
          encodedHabit[didUserSucced],
          encodedHabit[completedDates],
          encodedHabit[id],
        ],
      );
    });

    test('clear habits is completed succesfully', () async {
      await database.rawDelete("DELETE FROM $habitsTable");

      var afterDelete = await database.rawQuery("SELECT * FROM $habitsTable");

      expect(afterDelete.length, 0);
    });

    test('clear deactive habits is completed succesfully', () async {
      await database.rawDelete("DELETE FROM $habitsTable WHERE $didUserSucced = 1");

      var afterDelete = await database.rawQuery("SELECT * FROM $habitsTable");

      expect(afterDelete.length, 0);
    });

    test('Database closed succesfully', () async {
      await database.close();

      expect(database.isOpen, false);
    });
  });
}
