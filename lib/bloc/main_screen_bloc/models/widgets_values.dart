import 'package:equatable/equatable.dart';

class WidgetValues extends Equatable {
  final String today;
  final String yesterday;
  final String tommorow;

  final bool todayBool;
  final bool yesterdayBool;
  final bool tommorowBool;

  final double percent;

  const WidgetValues(
      {required this.today,
      required this.yesterday,
      required this.tommorow,
      required this.todayBool,
      required this.yesterdayBool,
      required this.tommorowBool,
      required this.percent});

  const WidgetValues.empty(
      {this.today = "Gün yok",
      this.yesterday = "Gün yok",
      this.tommorow = "Gün yok",
      this.todayBool = false,
      this.tommorowBool = false,
      this.yesterdayBool = false,
      this.percent = 0});

  WidgetValues copyWith(
      {String? today,
      String? yesterday,
      String? tommorow,
      bool? todayBool,
      bool? yesterdayBool,
      bool? tommorowBool,
      double? percent}) {
    return WidgetValues(
        today: today ?? this.today,
        yesterday: yesterday ?? this.yesterday,
        tommorow: tommorow ?? this.tommorow,
        todayBool: tommorowBool ?? this.todayBool,
        yesterdayBool: yesterdayBool ?? this.yesterdayBool,
        tommorowBool: tommorowBool ?? this.tommorowBool,
        percent: percent ?? this.percent);
  }

  @override
  List<Object?> get props => [
        today,
        yesterday,
        tommorow,
        todayBool,
        yesterdayBool,
        tommorowBool,
        percent
      ];
}
