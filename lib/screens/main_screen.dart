import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_habits/bloc/adding_screen_bloc/adding_screen_bloc.dart';
import 'package:make_habits/screens/adding_screen.dart';
import 'package:make_habits/services/habit_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:make_habits/assets/headings.dart';

import '../bloc/main_screen_bloc/main_screen_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MainScreenBloc(RepositoryProvider.of<HabitService>(context))
            ..add(MainScreenInitialEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(appName),
        ),
        body: BlocBuilder<MainScreenBloc, MainScreenState>(
          builder: (context, state) {
            if (state is MainScreenErrorState) {
              return Center(child: Text(state.e));
            }
            if (state is MainScreenLoadedState) {
              context
                  .read<MainScreenBloc>()
                  .add(MainScreenLoadedEvent(state.habits, index: 0));
              const Center(child: CircularProgressIndicator());
            }
            if (state is MainScreenCheckBoxState) {
              return buildMainScreen(state);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildMainScreen(MainScreenCheckBoxState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 12),
            child: CircularPercentIndicator(
              progressColor: const Color(0xff3f51b5),
              animation: true,
              animationDuration: 2000,
              radius: MediaQuery.of(context).size.width / 4,
              lineWidth: MediaQuery.of(context).size.width / 16,
              percent: state.percent / 100,
              center: Text(
                "%${state.percent.toStringAsFixed(1)}",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.yesterday),
              Checkbox(
                  value: state.yesterdayBool,
                  onChanged: change,
                  activeColor: Colors.green),
              const Spacer(),
              Text(state.today),
              Checkbox(
                value: state.todayBool,
                onChanged: change,
                activeColor: Colors.green,
              ),
              const Spacer(),
              Text(state.tommorow),
              Checkbox(
                value: state.tommorowBool,
                onChanged: change,
                activeColor: Colors.green,
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(155, 50)),
                  onPressed: () => pushAddPage(),
                  child: const Text(mainScreenButton1)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(155, 50)),
                  onPressed: () => Navigator.pushNamed(context, "/List"),
                  child: const Text(mainScreenButton2)),
            ],
          ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(155, 50)),
                  onPressed: () {},
                  child: const Text(mainScreenButton3)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(155, 50)),
                  onPressed: () {},
                  child: const Text(mainScreenButton4)),
            ],
          ),
        ],
      ),
    );
  }

  void pushAddPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => BlocProvider(
            create: (context) =>
                AddingScreenBloc(RepositoryProvider.of<HabitService>(context))
                  ..add(AddingScreenInitialEvent()),
            child: const AddingScreen()))));
  }

  void change(bool? boolean) {}
}
