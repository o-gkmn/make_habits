import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:make_habits/assets/headings.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'screens.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(appName)),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBar(context,
                      icon: IconlyLight.home, page: 0, label: "Ana Menü"),
                  _bottomAppBar(context,
                      icon: IconlyLight.tick_square, page: 1, label: "Günler"),
                  _bottomAppBar(context,
                      icon: IconlyLight.plus, page: 2, label: "Ekle"),
                  _bottomAppBar(context,
                      icon: IconlyLight.activity, page: 2, label: "Liste"),
                ]),
          ),
        ),
        body: PageView(
          physics: const BouncingScrollPhysics(),
          children: const [
            ActionOverView(),
            DayTrackerScreen(),
            AddingScreen(),
            ActionListScreen(),
          ],
        ));
  }

  Widget _bottomAppBar(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            Text(label),
          ],
        ),
      ),
    );
  }
}
