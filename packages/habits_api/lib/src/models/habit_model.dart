import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit_model.g.dart';

enum Frequency {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

@JsonSerializable()
class Habit extends Equatable {
  final int id;
  final String title;
  final DateTime? startDate;
  final DateTime? remainder;
  final int timerInDay;
  final int repeatCountInDay;
  final bool isActive;
  final List<Frequency> frequency;
  final List<DateTime> completedDates;

  const Habit({
    required this.id,
    required this.title,
    required this.startDate,
    required this.remainder,
    required this.timerInDay,
    required this.repeatCountInDay,
    required this.isActive,
    required this.frequency,
    required this.completedDates,
  });

  const Habit.blank({
    this.id = 0,
    this.title = "",
    this.startDate,
    this.remainder,
    this.timerInDay = 0,
    this.repeatCountInDay = 0,
    this.isActive = false,
    this.frequency = const [],
    this.completedDates = const [],
  });

  Habit copyWith({
    int? id,
    String? title,
    DateTime? startDate,
    DateTime? remainder,
    int? timerInDay,
    int? repeatCountInDay,
    bool? isActive,
    List<Frequency>? frequency,
    List<DateTime>? completedDates,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      remainder: remainder ?? this.remainder,
      timerInDay: timerInDay ?? this.timerInDay,
      repeatCountInDay: repeatCountInDay ?? this.repeatCountInDay,
      isActive: isActive ?? this.isActive,
      frequency: frequency ?? this.frequency,
      completedDates: completedDates ?? this.completedDates,
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);

  @override
  List<Object?> get props => [
        title,
        startDate,
        remainder,
        frequency,
        repeatCountInDay,
        isActive,
        completedDates,
      ];
}
