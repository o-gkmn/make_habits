import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:make_habits/bloc/adding_screen_bloc/adding_screen_bloc.dart';
import 'package:make_habits/bloc/day_tracker_bloc/day_tracker_bloc.dart';
import 'package:make_habits/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:make_habits/screens/action_list_screen.dart';
import 'package:make_habits/screens/adding_screen.dart';
import 'package:make_habits/screens/day_tracker_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:make_habits/assets/headings.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            MainScreenBloc(RepositoryProvider.of<HabitRepository>(context))
              ..add(MainScreenInitialEvent(index: ActionListScreen.onTapIndex)),
        child: Scaffold(
            appBar: AppBar(title: const Text(appName)),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocListener<MainScreenBloc, MainScreenState>(
                  listener: (context, state) {
                    if (state is MainScreenErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(createSnackBar(
                          text: state.e.toString(),
                          color: const Color(0xffff3838)));
                    }
                  },
                  child: const MainScreenForm(),
                ))));
  }
}

class MainScreenForm extends StatelessWidget {
  const MainScreenForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
      return Column(children: [
        const Spacer(flex: 1),
        _PercentIndicator(),
        const Spacer(flex: 1),
        const Divider(),
        const Spacer(flex: 1),
        Row(children: [
          Text(state.widgetValues.yesterday),
          _YesterdayCheckBox(),
          const Spacer(flex: 1),
          Text(state.widgetValues.today),
          _TodayCheckBox(),
          const Spacer(flex: 1),
          Text(state.widgetValues.tommorow),
          _TommorowCheckBox()
        ]),
        const Spacer(flex: 1),
        const Divider(),
        const Spacer(flex: 1),
        Row(children: [
          const Spacer(flex: 1),
          _AddingScreenButton(),
          const Spacer(flex: 1),
          _ActionListButton(),
          const Spacer(flex: 1),
        ]),
        const SizedBox(height: 15.0),
        Row(children: [
          const Spacer(flex: 1),
          _DaysTrackerButton(),
          const Spacer(flex: 1),
          _DeactiveActionListButton(),
          const Spacer(flex: 1),
        ]),
        const Spacer(flex: 1)
      ]);
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
              progressColor: const Color(0xff3f51b5),
              animation: true,
              animationDuration: 2000,
              radius: MediaQuery.of(context).size.width / 4,
              lineWidth: MediaQuery.of(context).size.width / 16,
              percent: state.habit.percent / 100,
              center: Text(
                "%${state.habit.percent.toStringAsFixed(1)}",
                style: Theme.of(context).textTheme.headline4,
              )));
    });
  }
}

class _YesterdayCheckBoxState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
      return Checkbox(
          value: context.read<MainScreenBloc>().yesterdayBool,
          onChanged: (value) => context.read<MainScreenBloc>().add(
              MainScreenCheckEvent(
                  value!, state.habit, state.widgetValues.yesterday)),
          activeColor: Colors.green);
    });
  }
}

class _TodayCheckBoxState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: ((context, state) {
      return Checkbox(
        value: context.read<MainScreenBloc>().todayBool,
        onChanged: (value) => context.read<MainScreenBloc>().add(
            MainScreenCheckEvent(
                value!, state.habit, state.widgetValues.today)),
        activeColor: Colors.green,
      );
    }));
  }
}

class _TommorowCheckBoxState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: ((context, state) {
      return Checkbox(
        value: context.read<MainScreenBloc>().tommorowBool,
        onChanged: (value) => context.read<MainScreenBloc>().add(
            MainScreenCheckEvent(
                value!, state.habit, state.widgetValues.tommorow)),
        activeColor: Colors.green,
      );
    }));
  }
}

class _AddingScreenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(155, 50)),
          onPressed: () => pushAddPage(context),
          child: const Text(mainScreenButton1));
    });
  }

  void pushAddPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => BlocProvider(
            create: (context) => AddingScreenBloc(
                RepositoryProvider.of<HabitRepository>(context))
              ..add(AddingScreenInitialEvent()),
            child: const AddingScreen()))));
  }
}

class _ActionListButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(155, 50)),
            onPressed: () => Navigator.popAndPushNamed(context, "/List"),
            child: const Text(mainScreenButton2));
      },
    );
  }
}

class _DaysTrackerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(155, 50)),
          onPressed: () {
            pushDayTrackerPage(context);
          },
          child: const Text(mainScreenButton3));
    });
  }

  void pushDayTrackerPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => BlocProvider(
            create: (context) => DayTrackerBloc(
                RepositoryProvider.of<HabitRepository>(context),
                ActionListScreen.onTapIndex),
            child: const DayTrackerScreen()))));
  }
}

class _DeactiveActionListButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(155, 50)),
            onPressed: () => pushDeactiveActionListScreen(context),
            child: const Text(mainScreenButton4));
      },
    );
  }

  void pushDeactiveActionListScreen(BuildContext context) {
    Navigator.of(context).popAndPushNamed("/DeactiveList");
  }
}

class _PercentIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PercentIndicatorState();
  }
}

class _YesterdayCheckBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _YesterdayCheckBoxState();
  }
}

class _TodayCheckBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodayCheckBoxState();
  }
}

class _TommorowCheckBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TommorowCheckBoxState();
  }
}
