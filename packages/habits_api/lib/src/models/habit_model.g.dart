// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      id: json['id'] as int,
      daysCount: json['daysCount'] as int,
      percent: (json['percent'] as num).toDouble(),
      name: json['name'] as String,
      didUserSucced: json['didUserSucced'] as bool,
      startDay: json['startDay'] as String,
      endDay: json['endDay'] as String,
      days: Map<String, bool>.from(json['days'] as Map),
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'id': instance.id,
      'daysCount': instance.daysCount,
      'percent': instance.percent,
      'name': instance.name,
      'startDay': instance.startDay,
      'endDay': instance.endDay,
      'didUserSucced': instance.didUserSucced,
      'days': instance.days,
    };
