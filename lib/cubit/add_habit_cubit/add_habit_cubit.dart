import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habits_api/models/models.dart';
import 'package:intl/intl.dart';

part 'add_habit_state.dart';

class AddHabitCubit extends Cubit<AddHabitState> {
  final HabitRepository _habitRepository;

  AddHabitCubit({required HabitRepository habitRepository})
      : _habitRepository = habitRepository,
        super(
          const AddHabitState(status: AddHabitStatus.initial),
        );

  void emitDate({
    String? title,
    String? selectedFirstDay,
    String? selectedFirstMonth,
    String? selectedFirstYear,
    String? selectedLastDay,
    String? selectedLastMonth,
    String? selectedLastYear,
  }) {
    emit(state.copyWith(
      title: title ?? state.title,
      selectedFirstDay: selectedFirstDay ?? state.selectedFirstDay,
      selectedFirstMonth: selectedFirstMonth ?? state.selectedFirstMonth,
      selectedFirstYear: selectedFirstYear ?? state.selectedFirstYear,
      selectedLastDay: selectedLastDay ?? state.selectedLastDay,
      selectedLastMonth: selectedLastMonth ?? state.selectedLastMonth,
      selectedLastYear: selectedLastYear ?? state.selectedLastYear,
    ));
  }

  void addHabit() async {
    final startDate =
        "${state.selectedFirstDay}.${state.selectedFirstMonth}.${state.selectedFirstYear}";
    final dueDate =
        "${state.selectedLastDay}.${state.selectedLastMonth}.${state.selectedLastYear}";

    DateTime formatFirstDate = DateFormat("dd.MM.yyyy").parse(startDate);
    DateTime formatLastDate = DateFormat("dd.MM.yyyy").parse(dueDate);

    int dayCount = formatLastDate.difference(formatFirstDate).inDays;

    if (formatFirstDate.isAfter(formatLastDate)) {
      emit(const AddHabitState(status: AddHabitStatus.error));
      throw Exception();
    }
    if (state.title.isEmpty) {
      emit(const AddHabitState(status: AddHabitStatus.error));
      throw Exception();
    }
    if (dayCount < 3) {
      emit(const AddHabitState(status: AddHabitStatus.error));
      throw Exception();
    }

    final dateList = <Date>[];

    for (int i = 0; i <= dayCount; ++i) {
      String date = DateFormat("dd.MM.yyyy")
          .format(formatFirstDate.add(Duration(days: i)));
      dateList.add(Date(dateId: 0, id: 0, date: date, isDone: false));
    }

    HabitAttribute habitAttribute = HabitAttribute(
        id: 0,
        title: state.title,
        startDate: startDate,
        dueTime: dueDate,
        howLongItWillTake: dayCount,
        isActive: true);

    Habit habit = Habit(habitAttribute: habitAttribute, dates: dateList);

    await _habitRepository.insertHabit(habit);

    emitDate(
      title: "",
      selectedFirstDay: DateTime.now().day.toString(),
      selectedFirstMonth: DateTime.now().month.toString(),
      selectedFirstYear: DateTime.now().year.toString(),
      selectedLastDay: DateTime.now().day.toString(),
      selectedLastMonth: DateTime.now().month.toString(),
      selectedLastYear: DateTime.now().year.toString(),
    );
  }
}
