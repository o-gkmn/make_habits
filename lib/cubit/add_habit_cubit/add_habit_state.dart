part of 'add_habit_cubit.dart';

enum AddHabitStatus { initial, loading, loaded, error, added }

class AddHabitState extends Equatable {
  const AddHabitState(
      {required this.status,
      this.habit = const Habit.blank(),
      this.title = "",
      this.selectedFirstDay = "",
      this.selectedFirstMonth = "",
      this.selectedFirstYear = "",
      this.selectedLastDay = "",
      this.selectedLastMonth = "",
      this.selectedLastYear = "",
      this.exception});

  final AddHabitStatus status;
  final Habit habit;
  final String title;
  final String selectedFirstDay;
  final String selectedFirstMonth;
  final String selectedFirstYear;
  final String selectedLastDay;
  final String selectedLastMonth;
  final String selectedLastYear;
  final Exception? exception;

  AddHabitState copyWith({
    AddHabitStatus? status,
    Habit? habit,
    String? title,
    String? selectedFirstDay,
    String? selectedFirstMonth,
    String? selectedFirstYear,
    String? selectedLastDay,
    String? selectedLastMonth,
    String? selectedLastYear,
    Exception? exception,
  }) =>
      AddHabitState(
        status: status ?? this.status,
        habit: habit ?? this.habit,
        title: title ?? this.title,
        selectedFirstDay: selectedFirstDay ?? this.selectedFirstDay,
        selectedFirstMonth: selectedFirstMonth ?? this.selectedFirstMonth,
        selectedFirstYear: selectedFirstYear ?? this.selectedFirstYear,
        selectedLastDay: selectedLastDay ?? this.selectedLastDay,
        selectedLastMonth: selectedLastMonth ?? this.selectedLastMonth,
        selectedLastYear: selectedLastYear ?? this.selectedLastYear,
        exception: exception ?? this.exception,
      );

  @override
  List<Object> get props => [
        status,
        habit,
        title,
        selectedFirstDay,
        selectedFirstMonth,
        selectedFirstYear,
        selectedLastDay,
        selectedLastMonth,
        selectedLastYear,
      ];
}
