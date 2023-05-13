// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitAttribute _$HabitAttributeFromJson(Map<String, dynamic> json) =>
    HabitAttribute(
      id: json['id'] as int,
      title: json['title'] as String,
      startDate: json['startDate'] as String,
      dueTime: json['dueTime'] as String,
      howLongItWillTake: json['howLongItWillTake'] as int,
      isActive: json['isActive'] == 1 ? true : false,
    );

Map<String, dynamic> _$HabitAttributeToJson(HabitAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate,
      'dueTime': instance.dueTime,
      'howLongItWillTake': instance.howLongItWillTake,
      'isActive': instance.isActive ? 1 : 0,
    };
