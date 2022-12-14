import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:make_habits/assets/headings.dart';
import 'package:make_habits/bloc/adding_screen_bloc/adding_screen_bloc.dart';

final days = List<String>.generate(31, (i) => (i + 1).toString());
final months = List<String>.generate(12, (i) => (i + 1).toString());
final years = List<String>.generate(12, (i) => (i + 2022).toString());

final nameController = TextEditingController();

String selectedFirstDay = DateTime.now().day.toString();
String selectedFirstMonth = DateTime.now().month.toString();
String selectedFirstYear = DateTime.now().year.toString();
String selectedLastDay = DateTime.now().day.toString();
String selectedLastMonth = DateTime.now().month.toString();
String selectedLastYear = DateTime.now().year.toString();

void resetPage() {
  nameController.text = "";
  selectedFirstDay = DateTime.now().day.toString();
  selectedFirstMonth = DateTime.now().month.toString();
  selectedFirstYear = DateTime.now().year.toString();
  selectedLastDay = DateTime.now().day.toString();
  selectedLastMonth = DateTime.now().month.toString();
  selectedLastYear = DateTime.now().year.toString();
}

SnackBar createSnackBar({required String text, required Color color}) {
  return SnackBar(
    content: Text(text),
    backgroundColor: color,
  );
}

class AddingScreen extends StatelessWidget {
  const AddingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddingScreenBloc>(
        create: (context) =>
            AddingScreenBloc(RepositoryProvider.of<HabitRepository>(context))
              ..add(AddingScreenInitialEvent()),
        child: Scaffold(
            appBar: AppBar(title: const Text(addingScreenAppTitle)),
            body:
                const Padding(padding: EdgeInsets.all(8.0), child: AddForm())));
  }
}

class AddForm extends StatelessWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddingScreenBloc, AddingScreenState>(
      bloc: BlocProvider.of<AddingScreenBloc>(context),
      listener: (context, state) {
        if (state is AddingScreenErrorState) {
          Color color = const Color(0xffff3838);
          if (state.status == Status.succes) {
            color = const Color(0xff3ae374);
            resetPage();
          }
          ScaffoldMessenger.of(context).showSnackBar(createSnackBar(
              text: state.printError(state.status), color: color));
          context.read<AddingScreenBloc>().add(AddingScreenErrorEvent());
        }
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              _NameInput(),
              const SizedBox(height: 50),
              const Text("Ba??lang???? tarihi"),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("G??n:"),
                  const Spacer(flex: 1),
                  _FirstDaySelector(),
                  const Spacer(flex: 2),
                  const Text("Ay:"),
                  const Spacer(flex: 1),
                  _FirstMonthSelector(),
                  const Spacer(flex: 2),
                  const Text("Y??l:"),
                  const Spacer(flex: 1),
                  _FirstYearSelector(),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 25),
                  const Text("Biti?? tarihi"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("G??n:"),
                      const Spacer(flex: 1),
                      _LastDaySelector(),
                      const Spacer(flex: 2),
                      const Text("Ay:"),
                      const Spacer(flex: 1),
                      _LastMonthSelector(),
                      const Spacer(flex: 2),
                      const Text("Y??l:"),
                      const Spacer(flex: 1),
                      _LastYearSelector()
                    ],
                  ),
                ],
              ),
              const Spacer(flex: 1),
              _SaveButton(),
              const Spacer(flex: 1),
            ],
          )),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddingScreenBloc, AddingScreenState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
                border: InputBorder.none, labelText: 'Etkinlik ismi'),
          ),
        );
      },
    );
  }
}

class _FirstDaySelectorState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddingScreenBloc, AddingScreenState>(
      bloc: BlocProvider.of<AddingScreenBloc>(context),
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: selectedFirstDay,
          items: days.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: ((value) {
            setState(() {
              selectedFirstDay = value as String;
            });
          }),
        );
      },
    );
  }
}

class _FirstMonthSelectorState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddingScreenBloc, AddingScreenState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: selectedFirstMonth,
          items: months.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: ((value) {
            setState(() {
              selectedFirstMonth = value as String;
            });
          }),
        );
      },
    );
  }
}

class _FirstYearSelectorState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddingScreenBloc, AddingScreenState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: selectedFirstYear,
          items: years.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: ((value) {
            setState(() {
              selectedFirstYear = value as String;
            });
          }),
        );
      },
    );
  }
}

class _LastDaySelectorState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddingScreenBloc, AddingScreenState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: selectedLastDay,
          items: days.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: ((value) {
            setState(() {
              selectedLastDay = value as String;
            });
          }),
        );
      },
    );
  }
}

class _LastMonthSelectorState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddingScreenBloc, AddingScreenState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: selectedLastMonth,
          items: months.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: ((value) {
            setState(() {
              selectedLastMonth = value as String;
            });
          }),
        );
      },
    );
  }
}

class _LastYearSelectorState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddingScreenBloc, AddingScreenState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: selectedLastYear,
          items: years.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: ((value) {
            setState(() {
              selectedLastYear = value as String;
            });
          }),
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddingScreenBloc, AddingScreenState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: () {
              context.read<AddingScreenBloc>().add(AddingScreenSaveEvent(
                  nameController.text,
                  selectedFirstDay,
                  selectedFirstMonth,
                  selectedFirstYear,
                  selectedLastDay,
                  selectedLastMonth,
                  selectedLastYear));
            },
            child: const Text("Kaydet"));
      },
    );
  }
}

class _FirstDaySelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstDaySelectorState();
  }
}

class _FirstMonthSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstMonthSelectorState();
  }
}

class _FirstYearSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstYearSelectorState();
  }
}

class _LastDaySelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LastDaySelectorState();
  }
}

class _LastMonthSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LastMonthSelectorState();
  }
}

class _LastYearSelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LastYearSelectorState();
  }
}
