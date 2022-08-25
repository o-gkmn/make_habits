import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit_model.g.dart';

/*
Bloc implementasyonunda model sınıfını equatable sınıfından extends edilir
*/
@JsonSerializable()
class Habit extends Equatable {
  final int id;
  final int daysCount;
  final String name;
  final String startDay;
  final String endDay;
  final bool didUserSucced;
  final Map<String, bool> days;

  const Habit(
      {required this.id,
      required this.daysCount,
      required this.name,
      required this.didUserSucced,
      required this.startDay,
      required this.endDay,
      required this.days});

  const Habit.empty(
      {this.id = -1,
      this.daysCount = 0,
      this.name = "",
      this.didUserSucced = false,
      this.startDay = "",
      this.endDay = "",
      this.days = const {}});

  Habit copyWith(
      {int? id,
      int? daysCount,
      String? name,
      String? startDay,
      String? endDay,
      bool? didUserSucced,
      Map<String, bool>? days}) {
    return Habit(
        id: id ?? this.id,
        daysCount: daysCount ?? this.daysCount,
        name: name ?? this.name,
        didUserSucced: didUserSucced ?? this.didUserSucced,
        startDay: startDay ?? this.startDay,
        endDay: endDay ?? this.endDay,
        days: days ?? this.days);
  }

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);

  @override
  List<Object?> get props =>
      [id, daysCount, name, startDay, endDay, didUserSucced, days];
}
