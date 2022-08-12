import 'package:make_habits/modals/habits_model.dart';

abstract class Services {
  Future<List<dynamic>> getData();

  void addData(HabitsModel data);

  void removeData(int id);

  void updateData(dynamic model);
}
