// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Date _$DateFromJson(Map<String, dynamic> json) => Date(
      dateId: json['dateId'] as int,
      id: json['id'] as int,
      date: json['date'] as String,
      isDone: json['isDone'] == 1 ? true : false ,
    );

Map<String, dynamic> _$DateToJson(Date instance) => <String, dynamic>{
      'dateId': instance.dateId,
      'id': instance.id,
      'date': instance.date,
      'isDone': instance.isDone ? 1 : 0,
    };
