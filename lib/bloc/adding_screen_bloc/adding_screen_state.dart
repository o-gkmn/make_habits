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
  const AddingScreenState();

  @override
  List<Object> get props => [];
}

class AddingScreenInitialState extends AddingScreenState {}

class AddingScreenLoadingState extends AddingScreenState {}

class AddingScreenLoadedState extends AddingScreenState {}

class AddingScreenErrorState extends AddingScreenState {
  final Status status;

  const AddingScreenErrorState(this.status);

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
