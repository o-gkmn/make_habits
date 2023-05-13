import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit_date_model.g.dart';

@JsonSerializable()
class Date extends Equatable {
  final int dateId;
  final int id;
  final String date;
  final bool isDone;

  Date copyWith({int? dateId, int? id, String? date, bool? isDone}) => Date(
        dateId: dateId ?? this.dateId,
        id: id ?? this.id,
        date: date ?? this.date,
        isDone: isDone ?? this.isDone,
      );

  const Date({required this.dateId, required this.id, required this.date, required this.isDone});

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);

  Map<String, dynamic> toJson() => _$DateToJson(this);

  @override
  List<Object?> get props => [dateId ,id, date, isDone];
}
