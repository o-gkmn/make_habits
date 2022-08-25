import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:make_habits/bloc/action_list_bloc/action_list_bloc.dart';
import 'package:make_habits/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:make_habits/screens/main_screen.dart';
import 'package:make_habits/assets/headings.dart';

void pushMainScreen(BuildContext context, int index) {
  ActionListScreen.onTapIndex = index;
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: ((context) => BlocProvider(
          create: (context) =>
              MainScreenBloc(RepositoryProvider.of<HabitRepository>(context))
                ..add(MainScreenInitialEvent(index: ActionListScreen.index)),
          child: const MainScreen()))));
}

class _ActionListState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ActionListBloc(RepositoryProvider.of<HabitRepository>(context))
              ..add(ActionListLoadEvent()),
        child: Scaffold(
            appBar: AppBar(
              title: const Text(actionListScreenAppTitle),
              actions: const [ClearAllButton()],
              elevation: 0,
              toolbarHeight: 100,
            ),
            body: BlocBuilder<ActionListBloc, ActionListState>(
                buildWhen: (previous, current) {
              return previous != current;
            }, builder: (context, state) {
              if (state is ActionListErrorState) {
                return ScreenView(
                    child: Center(child: Text(state.errorMsg.toString())));
              }
              if (state is ActionListLoadedState) {
                return ScreenView(
                    child: ListView.builder(
                        itemCount: state.habits.length,
                        itemBuilder: (BuildContext context, index) {
                          ActionListScreen.index = index;
                          return GestureDetector(
                              onTap: () => pushMainScreen(context, index),
                              child: RowDesign(index: index));
                        }));
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

class RowDesign extends StatelessWidget {
  final int index;
  const RowDesign({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionListBloc, ActionListState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => context
                            .read<ActionListBloc>()
                            .add(ActionListDeleteEvent(index)),
                        icon: Icons.delete_outline,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      )
                    ],
                  ),
                  child: Container(
                      height: 70,
                      color: Colors.white,
                      child: Row(children: [
                        const Leading(),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.habits[ActionListScreen.index].name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "${state.habits[ActionListScreen.index].startDay} tarihinde başladınız.",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                "${state.habits[ActionListScreen.index].endDay} tarihinde bitiyor.",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        )
                      ])))),
        );
      },
    );
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
        "${ActionListScreen.index + 1}",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class ClearAllButton extends StatelessWidget {
  const ClearAllButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.read<ActionListBloc>().add(ActionListClearAllEvent());
          Navigator.popAndPushNamed(context, "/");
        },
        icon: const Icon(Icons.clear_all));
  }
}

class ActionListScreen extends StatefulWidget {
  static int index = 0;
  static int onTapIndex = 0;
  const ActionListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ActionListState();
  }
}
