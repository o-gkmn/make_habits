import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habits_model.g.dart';

/*
Bloc implementasyonunda model sınıfını equatable sınıfından extends edilir
*/
@JsonSerializable()
// ignore: must_be_immutable
class HabitsModel extends Equatable {
  int id;
  int daysCount;
  String name;
  String startDay;
  String endDay;
  bool didUserSucced;
  Map<String, bool> days;

  HabitsModel(this.id, this.daysCount, this.name, this.didUserSucced,
      this.startDay, this.endDay, this.days);

  factory HabitsModel.fromJson(Map<String, dynamic> json) =>
      _$HabitsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HabitsModelToJson(this);

  @override
  List<Object?> get props =>
      [id, daysCount, name, startDay, endDay, didUserSucced, days];
}
