import 'package:make_habits/data/data_provider.dart';
import 'package:make_habits/modals/habits_model.dart';
import 'package:make_habits/services/services.dart';

class HabitService extends Services {
  final DataProvider _db = DataProvider();

  @override
  Future<List<HabitsModel>> getData() async {
    List<HabitsModel> habits = <HabitsModel>[];
    var dataFuture = await _db.getData();
    habits = dataFuture.cast();
    return habits;
  }

  @override
  void addData(HabitsModel data) {
    return _db.addData(data);
  }

  @override
  void removeData(int id) {
    return _db.deleteData(id);
  }

  @override
  void updateData(model) {
    if (model is HabitsModel) {
      _db.updataData(model);
    }
  }
}
