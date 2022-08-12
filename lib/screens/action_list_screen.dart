import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_habits/bloc/action_list_bloc/action_list_bloc.dart';
import 'package:make_habits/services/habit_service.dart';
import 'package:make_habits/assets/headings.dart';

class ActionListScreen extends StatefulWidget {
  const ActionListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ActionListState();
  }
}

class _ActionListState extends State {
  @override
  Widget build(BuildContext context) {
    /*
    BlocProvider ile blocu bu sınıf için sağlıyorum.
    RepositoryProvider.of<HabitService>(context) => mainde tanımladığımız
    RepositoryProviderdan geliyor.
    ..ad(HabitsLoadEvent()) => İlk gerçekleşecek eventi ekliyor
    */
    return BlocProvider(
      create: (context) =>
          ActionListBloc(RepositoryProvider.of<HabitService>(context))
            ..add(ActionListLoadEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(actionListScreenAppTitle),
        ),
        /*
        Blocu yapılandırıyorum.
        Hangi statete hangi kodların çalışacağını if else bloğu ile sağlıyorum
        */
        body: BlocBuilder<ActionListBloc, ActionListState>(
            builder: (context, state) {
          if (state is ActionListErrorState) {
            return Center(child: Text(state.errorMsg));
          }
          if (state is ActionListLoadedState) {
            return ListView.builder(
              itemCount: state.habits.length,
              itemBuilder: (BuildContext context, index) {
                return buildListItem(index, state);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  Widget buildListItem(int index, ActionListLoadedState state) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 70,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.amberAccent,
                width: 70,
                height: 70,
                child: Text(
                  "${index + 1}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.habits[index].name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "${state.habits[index].startDay} tarihinde başladınız.",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      "${state.habits[index].endDay} tarihinde bitiyor.",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.blue)
            ],
          ),
        ),
      ),
    );
  }
}
