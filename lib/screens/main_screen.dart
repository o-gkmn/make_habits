import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_habits/bloc/adding_screen_bloc/adding_screen_bloc.dart';
import 'package:make_habits/bloc/day_tracker_bloc/day_tracker_bloc.dart';
import 'package:make_habits/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:make_habits/screens/action_list_screen.dart';
import 'package:make_habits/screens/adding_screen.dart';
import 'package:make_habits/screens/day_tracker_screen.dart';
import 'package:make_habits/services/habit_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:make_habits/assets/headings.dart';

void change(bool? boolean) {}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(appName)),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocProvider(
              create: (context) => MainScreenBloc(
                  RepositoryProvider.of<HabitService>(context))
                ..add(MainScreenInitialEvent(index: ActionListScreen.index)),
              child: const MainScreenForm(),
            )));
  }
}

class MainScreenForm extends StatelessWidget {
  const MainScreenForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainScreenBloc, MainScreenState>(
        bloc: BlocProvider.of<MainScreenBloc>(context),
        listener: (context, state) {
          if (state is MainScreenErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(createSnackBar(
                text: state.e.toString(), color: const Color(0xffff3838)));
          }
        },
        child: Column(children: [
          _PercentIndicator(),
          const Spacer(flex: 1),
          const Divider(),
          const Spacer(flex: 1),
          Row(children: [
            Text(context.watch<MainScreenBloc>().yesterdayString),
            _YesterdayCheckBox(),
            const Spacer(flex: 1),
            Text(context.read<MainScreenBloc>().todayString),
            _TodayCheckBox(),
            const Spacer(flex: 1),
            Text(context.read<MainScreenBloc>().tommorowString),
            _TommorowCheckBox()
          ]),
          const Spacer(flex: 1),
          const Divider(),
          const Spacer(flex: 1),
          Row(children: [
            _AddingScreenButton(),
            const Spacer(flex: 1),
            _ActionListButton(),
          ]),
          const SizedBox(height: 15.0),
          Row(children: [
            _DaysTrackerButton(),
            const Spacer(flex: 1),
            _Button4(),
          ]),
          const Spacer(flex: 1)
        ]));
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
              percent: context.read<MainScreenBloc>().percent / 100,
              center: Text(
                "%${context.read<MainScreenBloc>().percent.toStringAsFixed(1)}",
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
          onChanged: change,
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
        onChanged: change,
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
        onChanged: change,
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
            create: (context) =>
                AddingScreenBloc(RepositoryProvider.of<HabitService>(context))
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
                RepositoryProvider.of<HabitService>(context),
                ActionListScreen.index),
            child: const DayTrackerScreen()))));
  }
}

class _Button4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(155, 50)),
            onPressed: () {},
            child: const Text(mainScreenButton3));
      },
    );
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
