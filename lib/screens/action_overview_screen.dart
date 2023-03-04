import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:make_habits/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:make_habits/screens/action_list_screen.dart';
import 'package:make_habits/screens/adding_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ActionOverView extends StatelessWidget {
  const ActionOverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MainScreenBloc(RepositoryProvider.of<HabitRepository>(context))
            ..add(MainScreenInitialEvent(index: ActionListScreen.onTapIndex)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<MainScreenBloc, MainScreenState>(
          listener: (context, state) {
            if (state is MainScreenErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                createSnackBar(
                  text: state.e.toString(),
                  color: const Color(0xffff3838),
                ),
              );
            }
          },
          child: const _MainScreenForm(),
        ),
      ),
    );
  }
}

class _MainScreenForm extends StatelessWidget {
  const _MainScreenForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Spacer(flex: 1),
        _HabitInformationCard(),
        Spacer(flex: 1),
        Divider(),
        _DayCheckBox(),
        Divider(),
        Spacer(flex: 2)
      ],
    );
  }
}

class _HabitInformationCard extends StatelessWidget {
  const _HabitInformationCard();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
      return Card(
        elevation: 30.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _PercentIndicator(),
              const SizedBox(width: 5.0),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.habit.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10.0),
                    Text("${state.habit.startDay} - ${state.habit.endDay}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _PercentIndicatorState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 12),
          child: CircularPercentIndicator(
            animation: true,
            animationDuration: 2000,
            radius: MediaQuery.of(context).size.width / 4,
            lineWidth: MediaQuery.of(context).size.width / 16,
            percent: state.habit.percent / 100,
            center: Text(
              "%${state.habit.percent.toStringAsFixed(1)}",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        );
      },
    );
  }
}

class _DayCheckBox extends StatelessWidget {
  const _DayCheckBox();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
      return Flexible(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: state.habit.daysCount,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Text(state.habit.days.keys.elementAt(index)),
                Checkbox(
                  value: state.habit.days.values.elementAt(index),
                  onChanged: (value) {},
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              ],
            );
          },
        ),
      );
    });
  }
}

class _PercentIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PercentIndicatorState();
  }
}
