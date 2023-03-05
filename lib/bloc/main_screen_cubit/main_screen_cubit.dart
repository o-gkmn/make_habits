import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenState());

  void goToTab(int page) {
    state.controller.jumpToPage(page);
    emit(state.copyWith(currentPage: page));
  }

  void animateToTab(int page) {
    state.controller.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    emit(state.copyWith(currentPage: page));
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
