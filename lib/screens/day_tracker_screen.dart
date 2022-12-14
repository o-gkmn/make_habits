import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:make_habits/bloc/day_tracker_bloc/day_tracker_bloc.dart';
import 'package:make_habits/screens/action_list_screen.dart';

bool isChecked = false;

class DayTrackerScreen extends StatelessWidget {
  const DayTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DayTrackerBloc(
          RepositoryProvider.of<HabitRepository>(context),
          ActionListScreen.onTapIndex)
        ..add(DayTrackerInitialEvent()),
      child: BlocBuilder<DayTrackerBloc, DayTrackerState>(
        builder: (context, state) {
          if (state is DayTrackerLoadedState) {
            return Scaffold(
                appBar: AppBar(
                  title: Column(children: [
                    Text(state.habit.name),
                    const SizedBox(height: 5),
                    Text("${state.habit.startDay} - ${state.habit.endDay}",
                        style: Theme.of(context).textTheme.labelSmall)
                  ]),
                  elevation: 0,
                  toolbarHeight: 100,
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      onPressed: () => Navigator.pop(context),
                      iconSize: 25),
                ),
                body: const DayTrackerBody());
          }
          return Scaffold(
              appBar: AppBar(
                title: const Text("Yükleniyor..."),
                elevation: 0,
                toolbarHeight: 100,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    onPressed: () => Navigator.pop(context),
                    iconSize: 25),
              ),
              body: const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class DayTrackerBody extends StatelessWidget {
  const DayTrackerBody({Key? key}) : super(key: key);
  static int dayIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayTrackerBloc, DayTrackerState>(
        builder: (context, state) {
      return Container(
        color: Theme.of(context).primaryColor,
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 2, 2),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(50.0))),
            child: ListView.builder(
                itemCount: state.habit.days.length,
                itemBuilder: (BuildContext context, index) {
                  dayIndex = index;
                  return ListAppearance(index: index);
                })),
      );
    });
  }
}

class ListAppearanceState extends State<ListAppearance> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayTrackerBloc, DayTrackerState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              onPressed: () {
                setState(() {
                  state.habit
                          .days[state.habit.days.keys.elementAt(widget.index)] =
                      !state.habit.days.values.elementAt(widget.index);
                });
                context.read<DayTrackerBloc>().add(DayTrackerChangeEvent(
                    state.habit,
                    state.habit.days.keys.elementAt(widget.index)));
              },
              child: Container(
                  padding: const EdgeInsets.only(left: 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0xfff5f6fa)),
                  height: 70,
                  child: ListItem(indeX: widget.index)),
            ));
      },
    );
  }
}

class ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayTrackerBloc, DayTrackerState>(
        builder: (context, state) {
      return Row(children: [
        Container(
            alignment: Alignment.center,
            height: 70,
            width: 70,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
                color: Colors.amber),
            child: Text("${widget.indeX + 1}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4)),
        const SizedBox(width: 10),
        Text(
          state.habit.days.keys.elementAt(widget.indeX),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(flex: 10),
        Checkbox(
          activeColor: Colors.green,
          value:
              state.habit.days[state.habit.days.keys.elementAt(widget.indeX)],
          onChanged: (value) {
            setState(() {
              state.habit.days[state.habit.days.keys.elementAt(widget.indeX)] =
                  value!;
            });
            context.read<DayTrackerBloc>().add(DayTrackerChangeEvent(
                state.habit, state.habit.days.keys.elementAt(widget.indeX)));
          },
        ),
        const Spacer(flex: 1),
      ]);
    });
  }
}

class ListItem extends StatefulWidget {
  final int indeX;
  const ListItem({Key? key, required this.indeX}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListItemState();
  }
}

class ListAppearance extends StatefulWidget {
  final int index;

  const ListAppearance({Key? key, required this.index}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ListAppearanceState();
  }
}
