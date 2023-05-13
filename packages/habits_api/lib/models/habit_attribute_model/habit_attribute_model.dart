import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit_attribute_model.g.dart';

@JsonSerializable()
class HabitAttribute extends Equatable {
  final int id;
  final String title;
  final String startDate;
  final String dueTime;
  final int howLongItWillTake;
  final bool isActive;

  const HabitAttribute({
    required this.id,
    required this.title,
    required this.startDate,
    required this.dueTime,
    required this.howLongItWillTake,
    required this.isActive,
  });

  const HabitAttribute.blank({
    this.id = 0,
    this.title = "",
    this.startDate = "",
    this.dueTime = "",
    this.howLongItWillTake = 0,
    this.isActive = false,
  });

  HabitAttribute copyWith({
    int? id,
    String? title,
    String? startDate,
    String? dueTime,
    int? howLongItWillTake,
    bool? isActive,
  }) {
    return HabitAttribute(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      dueTime: dueTime ?? this.dueTime,
      howLongItWillTake: howLongItWillTake ?? this.howLongItWillTake,
      isActive: isActive ?? this.isActive,
    );
  }

  factory HabitAttribute.fromJson(Map<String, dynamic> json) => _$HabitAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$HabitAttributeToJson(this);

  @override
  List<Object?> get props => [
        title,
        startDate,
        dueTime,
        howLongItWillTake,
        isActive,
      ];
}
