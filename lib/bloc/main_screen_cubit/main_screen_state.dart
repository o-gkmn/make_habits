part of 'main_screen_cubit.dart';

class MainScreenState extends Equatable {
  MainScreenState({this.currentPage = 0});

  final PageController controller = PageController();
  final int currentPage;

  MainScreenState copyWith({int? currentPage}) {
    return MainScreenState(
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [controller, currentPage];
}
