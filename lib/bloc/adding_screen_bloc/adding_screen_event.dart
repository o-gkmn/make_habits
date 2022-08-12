part of 'adding_screen_bloc.dart';

abstract class AddingScreenEvent extends Equatable {
  const AddingScreenEvent();

  @override
  List<Object> get props => [];
}

class AddingScreenInitialEvent extends AddingScreenEvent {}

class AddingScreenLoadingEvent extends AddingScreenEvent {}

class AddingScreenLoadedEvent extends AddingScreenEvent {}

class AddingScreenErrorEvent extends AddingScreenEvent {}

class AddingScreenSaveEvent extends AddingScreenEvent {
  final String name;

  final String firstDay;
  final String firstMonth;
  final String firstYear;

  final String lastDay;
  final String lastMonth;
  final String lastYear;

  const AddingScreenSaveEvent(this.name, this.firstDay, this.firstMonth,
      this.firstYear, this.lastDay, this.lastMonth, this.lastYear);

  @override
  List<Object> get props =>
      [name, firstDay, firstMonth, firstYear, lastDay, lastMonth, lastYear];
}
