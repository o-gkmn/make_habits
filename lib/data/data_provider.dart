import 'dart:convert';
import 'dart:io';

import 'package:make_habits/modals/habits_model.dart';
import 'package:path_provider/path_provider.dart';

class DataProvider {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    File file = File('$path/habits.json');
    if (await file.exists()) {
      return file;
    } else {
      return await file.create(recursive: true);
    }
  }

  Future<List<HabitsModel>> getData() async {
    File file = await _localFile;
    late String fileContent;
    List<HabitsModel> habits = [];

    fileContent = await file.readAsString();

    if (fileContent.isEmpty) {
      return habits;
    }

    var data = json.decode(fileContent);
    for (var d in data) {
      var habit = HabitsModel.fromJson(d);
      habits.add(habit);
    }
    return habits;
  }

  void addData(HabitsModel data) async {
    File file = await _localFile;
    List<HabitsModel> habits = await getData();
    habits.add(data);
    habits.map((habit) => habit.toJson()).toList();
    await file.writeAsString(json.encode(habits));
  }

  void deleteData(int id) {}

  void updataData(HabitsModel habit) {}
}
