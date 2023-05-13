import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'habit_model.g.dart';

@JsonSerializable()
class Habit extends Equatable {
  final HabitAttribute habitAttribute;
  final List<Date> dates;

  const Habit({required this.habitAttribute, required this.dates});

  const Habit.blank(
      {this.habitAttribute = const HabitAttribute.blank(), this.dates = const []});

  Habit copyWith({HabitAttribute? habitAttribute, List<Date>? dates}) =>
      Habit(habitAttribute: habitAttribute ?? this.habitAttribute, dates: dates ?? this.dates);

  factory Habit.fromJson(Map<String, dynamic> json) =>
      _$HabitFromJson(json);
  Map<String, dynamic> toJson() => _$HabitToJson(this);

  @override
  List<Object?> get props => [habitAttribute, dates];
}
