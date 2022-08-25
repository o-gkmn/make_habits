part of 'adding_screen_bloc.dart';

enum Status {
  initError,
  nameError,
  dateError,
  dayError,
  unknownDateError,
  unexpectedError,
  succes
}

abstract class AddingScreenState extends Equatable {
  const AddingScreenState({this.habits = const []});

  final List<Habit> habits;

  @override
  List<Object> get props => [habits];
}

class AddingScreenInitialState extends AddingScreenState {}

class AddingScreenLoadingState extends AddingScreenState {}

class AddingScreenLoadedState extends AddingScreenState {
  final List<Habit> habitsList;

  const AddingScreenLoadedState(this.habitsList) : super(habits: habitsList);

  @override
  List<Object> get props => [habitsList];
}

class AddingScreenErrorState extends AddingScreenState {
  final Status status;

  const AddingScreenErrorState(this.status) : super();

  String printError(Status status) {
    switch (status) {
      case Status.initError:
        return initErrorText;
      case Status.nameError:
        return nameErrorText;
      case Status.dateError:
        return dateErrorText;
      case Status.dayError:
        return dayCountErrorText;
      case Status.unknownDateError:
        return unknownDateErrorText;
      case Status.unexpectedError:
        return unexpectedErrorText;
      case Status.succes:
        return succesText;
    }
  }

  @override
  List<Object> get props => [status];
}

class AddingScreenSaveState extends AddingScreenState {}
