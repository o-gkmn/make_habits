part of 'main_screen_cubit.dart';

enum MainStatus { initial, loading, loaded, error }

class MainScreenState extends Equatable {
  MainScreenState({
    this.currentPage = 0,
    required this.status,
    this.completionRatio = 0.0,
    this.habit = const Habit.blank(),
    this.exception,
  });

  final PageController controller =
      PageController(keepPage: false, initialPage: 0);
  final MainStatus status;
  final int currentPage;
  final double completionRatio;
  final Habit habit;
  final Exception? exception;

  MainScreenState copyWith(
      {int? currentPage,
      MainStatus? status,
      double? completionRatio,
      Habit? habit,
      Exception? exception}) {
    return MainScreenState(
      currentPage: currentPage ?? this.currentPage,
      status: status ?? this.status,
      completionRatio: completionRatio ?? this.completionRatio,
      habit: habit ?? this.habit,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object> get props => [controller, status, currentPage, habit, completionRatio];
}
