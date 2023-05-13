// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      habitAttribute: HabitAttribute.fromJson(
          json['habitAttribute'] as Map<String, dynamic>),
      dates: (json['dates'] as List<dynamic>)
          .map((e) => Date.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'habitAttribute': instance.habitAttribute,
      'dates': instance.dates,
    };
