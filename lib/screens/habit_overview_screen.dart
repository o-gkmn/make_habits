import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_habits/cubit/cubits.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'screens.dart';

class HabitOverview extends StatelessWidget {
  const HabitOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocListener<MainScreenCubit, MainScreenState>(
        listener: (context, state) {
          if (state.status == MainStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              createSnackBar(
                text: state.exception.toString(),
                color: const Color(0xffff3838),
              ),
            );
          }
        },
        child: const _HabitOverviewForm(),
      ),
    );
  }
}

class _HabitOverviewForm extends StatelessWidget {
  const _HabitOverviewForm({Key? key}) : super(key: key);

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
    return BlocBuilder<MainScreenCubit, MainScreenState>(
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
                      state.habit.habitAttribute.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                        "${state.habit.habitAttribute.startDate} - ${state.habit.habitAttribute.dueTime}"),
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

class _PercentIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 12),
          child: CircularPercentIndicator(
            animation: true,
            animationDuration: 2000,
            radius: MediaQuery.of(context).size.width / 4,
            lineWidth: MediaQuery.of(context).size.width / 16,
            percent: state.completionRatio,
            center: Text(
              "%${(state.completionRatio * 100).toStringAsFixed(0)}",
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
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        return Flexible(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: state.habit.dates.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(state.habit.dates[index].date),
                  Checkbox(
                    value: state.habit.dates[index].isDone,
                    onChanged: (value) => context
                        .read<MainScreenCubit>()
                        .switchCheckBox(index, value!),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
