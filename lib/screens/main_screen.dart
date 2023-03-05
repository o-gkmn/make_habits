import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_habits/assets/headings.dart';
import 'package:make_habits/bloc/main_screen_cubit/main_screen_cubit.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'screens.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenCubit(),
      child: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(title: const Text(appName)),
              bottomNavigationBar: BottomAppBar(
                notchMargin: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _bottomAppBar(context,
                            icon: FluentSystemIcons.ic_fluent_home_regular,
                            page: 0,
                            label: "Ana Menü"),
                        _bottomAppBar(context,
                            icon: FluentSystemIcons
                                .ic_fluent_checkbox_checked_regular,
                            page: 1,
                            label: "Günler"),
                        _bottomAppBar(context,
                            icon: FluentSystemIcons.ic_fluent_add_regular,
                            page: 2,
                            label: "Ekle"),
                        _bottomAppBar(context,
                            icon: FluentSystemIcons.ic_fluent_list_regular,
                            page: 3,
                            label: "Liste"),
                      ]),
                ),
              ),
              body: PageView(
                onPageChanged: context.read<MainScreenCubit>().animateToTab,
                controller: state.controller,
                physics: const BouncingScrollPhysics(),
                children: const [
                  ActionOverview(),
                  DayTrackerScreen(),
                  AddingScreen(),
                  ActionListScreen(),
                ],
              ));
        },
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context,
      {required icon, required page, required label}) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        return ZoomTapAnimation(
          onTap: () => context.read<MainScreenCubit>().goToTab(page),
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon,
                    color: state.currentPage == page
                        ? Theme.of(context).primaryColor
                        : Colors.grey),
                Text(
                  label,
                  style: TextStyle(
                    color: state.currentPage == page
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    fontSize: 13,
                    fontWeight:
                        state.currentPage == page ? FontWeight.w600 : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
