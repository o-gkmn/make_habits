import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_habits/cubit/cubits.dart';

class DayTrackerScreen extends StatelessWidget {
  const DayTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainScreenCubit, MainScreenState>(
      listener: (context, state) {},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: DayTrackerBody(),
      ),
    );
  }
}

class DayTrackerBody extends StatelessWidget {
  const DayTrackerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.habit.dates.length,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () => context
                    .read<MainScreenCubit>()
                    .switchCheckBox(index, !state.habit.dates[index].isDone),
                child: Container(
                    padding: const EdgeInsets.only(left: 0.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: const Color(0xfff5f6fa)),
                    height: 70,
                    child: ListItem(index: index)),
              ),
            );
          },
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final int index;
  const ListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
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
          child: Text(
            "${index + 1}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          state.habit.dates[index].date,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(flex: 10),
        Checkbox(
          activeColor: Colors.green,
          value: state.habit.dates[index].isDone,
          onChanged: (value) =>
              context.read<MainScreenCubit>().switchCheckBox(index, value!),
        ),
        const Spacer(flex: 1),
      ]);
    });
  }
}
