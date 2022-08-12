// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitsModel _$HabitsModelFromJson(Map<String, dynamic> json) => HabitsModel(
      json['id'] as int,
      json['daysCount'] as int,
      json['name'] as String,
      json['didUserSucced'] as bool,
      json['startDay'] as String,
      json['endDay'] as String,
      Map<String, bool>.from(json['days'] as Map),
    );

Map<String, dynamic> _$HabitsModelToJson(HabitsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'daysCount': instance.daysCount,
      'name': instance.name,
      'startDay': instance.startDay,
      'endDay': instance.endDay,
      'didUserSucced': instance.didUserSucced,
      'days': instance.days,
    };
