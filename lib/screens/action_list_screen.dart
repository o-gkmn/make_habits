import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_habits/bloc/action_list_bloc/action_list_bloc.dart';
import 'package:make_habits/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:make_habits/screens/main_screen.dart';
import 'package:make_habits/services/habit_service.dart';
import 'package:make_habits/assets/headings.dart';

void pushMainScreen(BuildContext context, int index) {
  ActionListScreen.index = index;
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: ((context) => BlocProvider(
          create: (context) =>
              MainScreenBloc(RepositoryProvider.of<HabitService>(context))
                ..add(MainScreenInitialEvent(index: index)),
          child: const MainScreen()))));
}

class _ActionListState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(actionListScreenAppTitle),
          elevation: 0,
          toolbarHeight: 100,
        ),
        body: BlocProvider(
            create: (context) =>
                ActionListBloc(RepositoryProvider.of<HabitService>(context))
                  ..add(ActionListLoadEvent()),
            child: BlocBuilder<ActionListBloc, ActionListState>(
                builder: (context, state) {
              if (state is ActionListErrorState) {
                return ScreenView(child: Center(child: Text(state.errorMsg)));
              }
              if (state is ActionListLoadedState) {
                return ScreenView(
                  child: ListView.builder(
                      itemCount: state.habits.length,
                      itemBuilder: (BuildContext context, index) {
                        ActionListScreen.habitsIndex = index;
                        return const BodyDesign();
                      }),
                );
              }
              return const ScreenView(
                  child: Center(child: CircularProgressIndicator()));
            })));
  }
}

class ScreenView extends StatelessWidget {
  final Widget child;
  const ScreenView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 2, 2),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(50)),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: child));
  }
}

class BodyDesign extends StatelessWidget {
  const BodyDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
            onPressed: () =>
                pushMainScreen(context, ActionListScreen.habitsIndex),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                primary: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: const RowDesign()));
  }
}

class RowDesign extends StatelessWidget {
  const RowDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            height: 70,
            color: Colors.white,
            child: Row(children: const [
              Leading(),
              SizedBox(width: 10),
              RowContents(),
              Icon(Icons.arrow_forward_ios, color: Colors.blue)
            ])));
  }
}

class Leading extends StatelessWidget {
  const Leading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.amberAccent,
      width: 70,
      height: 70,
      child: Text(
        "${ActionListScreen.habitsIndex + 1}",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class RowContents extends StatelessWidget {
  const RowContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionListBloc, ActionListState>(
      builder: (context, state) {
        if (state is ActionListLoadedState) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.habits[ActionListScreen.habitsIndex].name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "${state.habits[ActionListScreen.habitsIndex].startDay} tarihinde başladınız.",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  "${state.habits[ActionListScreen.habitsIndex].endDay} tarihinde bitiyor.",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          );
        }
        return const Text("Yükleniyor...");
      },
    );
  }
}

class ActionListScreen extends StatefulWidget {
  static int index = 0;
  static int habitsIndex = 0;
  const ActionListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ActionListState();
  }
}
