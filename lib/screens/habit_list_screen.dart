import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habits_api/models/models.dart';
import 'package:make_habits/cubit/cubits.dart';

void pushMainScreen(BuildContext context, Habit habit) {
  context.read<MainScreenCubit>().goToTab(0, habit: habit);
}

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitListCubit(
          habitRepository: RepositoryProvider.of<HabitRepository>(context)),
      child: BlocBuilder<HabitListCubit, HabitListState>(
          builder: (context, state) {
        if (state.status == HabitListStatus.initial) {
          context.read<HabitListCubit>().loadHabitList();
        }
        if (state.status == HabitListStatus.error) {
          return Center(
            child: Text(
              state.exception.toString(),
            ),
          );
        }
        if (state.status == HabitListStatus.loaded) {
          return Stack(
            children: const [
              RowDesign(index: 0),
              ClearAllButton(),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

class RowDesign extends StatelessWidget {
  final int index;
  const RowDesign({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitListCubit, HabitListState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.habits.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () => pushMainScreen(context, state.habits[index]),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => context
                              .read<HabitListCubit>()
                              .deleteHabit(
                                  state.habits[index].habitAttribute.id),
                          icon: Icons.delete_outline,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        )
                      ],
                    ),
                    child: Container(
                      height: 70,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Leading(index: index),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.habits[index].habitAttribute.title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  "${state.habits[index].habitAttribute.startDate} tarihinde başladınız.",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  "${state.habits[index].habitAttribute.dueTime} tarihinde bitiyor.",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Leading extends StatelessWidget {
  final int index;
  const Leading({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.amberAccent,
      width: 70,
      height: 70,
      child: Text(
        "${index + 1}",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class ClearAllButton extends StatelessWidget {
  const ClearAllButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Ink(
          width: 58.0,
          height: 58.0,
          decoration: const ShapeDecoration(
            color: Colors.blue,
            shape: CircleBorder(),
          ),
          child: IconButton(
              icon:
                  const Icon(FluentSystemIcons.ic_fluent_delete_forever_filled),
              color: Colors.white,
              onPressed: () {
                context.read<HabitListCubit>().clearAll();
                context
                    .read<MainScreenCubit>()
                    .goToTab(0, habit: const Habit.blank());
              }),
        ),
      ),
    );
  }
}
