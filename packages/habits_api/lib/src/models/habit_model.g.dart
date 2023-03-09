// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      id: json['id'] as int,
      title: json['title'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      remainder: json['remainder'] == null
          ? null
          : DateTime.parse(json['remainder'] as String),
      timerInDay: json['timerInDay'] == null
          ? null
          : DateTime.parse(json['timerInDay'] as String),
      repeatCountInDay: json['repeatCountInDay'] as int,
      isActive: json['isActive'] as bool,
      frequency: (json['frequency'] as List<dynamic>)
          .map((e) => $enumDecode(_$FrequencyEnumMap, e))
          .toList(),
      completedDates: (json['completedDates'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate?.toIso8601String(),
      'remainder': instance.remainder?.toIso8601String(),
      'timerInDay': instance.timerInDay?.toIso8601String(),
      'repeatCountInDay': instance.repeatCountInDay,
      'isActive': instance.isActive,
      'frequency':
          instance.frequency.map((e) => _$FrequencyEnumMap[e]!).toList(),
      'completedDates':
          instance.completedDates.map((e) => e.toIso8601String()).toList(),
    };

const _$FrequencyEnumMap = {
  Frequency.monday: 'monday',
  Frequency.tuesday: 'tuesday',
  Frequency.wednesday: 'wednesday',
  Frequency.thursday: 'thursday',
  Frequency.friday: 'friday',
  Frequency.saturday: 'saturday',
  Frequency.sunday: 'sunday',
};
