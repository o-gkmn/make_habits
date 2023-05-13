import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:make_habits/cubit/cubits.dart';

final days = List<String>.generate(31, (i) => (i + 1).toString());
final months = List<String>.generate(12, (i) => (i + 1).toString());
final years = List<String>.generate(12, (i) => (i + 2022).toString());

final titleController = TextEditingController();

String selectedFirstDay = DateTime.now().day.toString();
String selectedFirstMonth = DateTime.now().month.toString();
String selectedFirstYear = DateTime.now().year.toString();
String selectedLastDay = DateTime.now().day.toString();
String selectedLastMonth = DateTime.now().month.toString();
String selectedLastYear = DateTime.now().year.toString();

void resetPage() {
  titleController.text = "";
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
    return BlocProvider<AddHabitCubit>(
      create: (context) => AddHabitCubit(
        habitRepository: RepositoryProvider.of<HabitRepository>(context),
      ),
      child: const AddForm(),
    );
  }
}

class AddForm extends StatelessWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddHabitCubit, AddHabitState>(
      bloc: BlocProvider.of<AddHabitCubit>(context),
      listener: (context, state) {
        if (state.status == AddHabitStatus.error) {
          Color color = const Color(0xffff3838);
          ScaffoldMessenger.of(context).showSnackBar(
            createSnackBar(
              text: state.exception.toString(),
              color: color,
            ),
          );
        }
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              _TitleInput(),
              const SizedBox(height: 50),
              const Text("Başlangıç tarihi"),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Gün:"),
                  const Spacer(flex: 1),
                  _FirstDaySelector(),
                  const Spacer(flex: 2),
                  const Text("Ay:"),
                  const Spacer(flex: 1),
                  _FirstMonthSelector(),
                  const Spacer(flex: 2),
                  const Text("Yıl:"),
                  const Spacer(flex: 1),
                  _FirstYearSelector(),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 25),
                  const Text("Bitiş tarihi"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Gün:"),
                      const Spacer(flex: 1),
                      _LastDaySelector(),
                      const Spacer(flex: 2),
                      const Text("Ay:"),
                      const Spacer(flex: 1),
                      _LastMonthSelector(),
                      const Spacer(flex: 2),
                      const Text("Yıl:"),
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

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddHabitCubit, AddHabitState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Etkinlik ismi',
            ),
          ),
        );
      },
    );
  }
}

class _FirstDaySelectorState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddHabitCubit, AddHabitState>(
      bloc: BlocProvider.of<AddHabitCubit>(context),
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
    return BlocBuilder<AddHabitCubit, AddHabitState>(
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
    return BlocBuilder<AddHabitCubit, AddHabitState>(
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
    return BlocBuilder<AddHabitCubit, AddHabitState>(
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
    return BlocBuilder<AddHabitCubit, AddHabitState>(
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
    return BlocBuilder<AddHabitCubit, AddHabitState>(
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
    return BlocBuilder<AddHabitCubit, AddHabitState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<AddHabitCubit>().addHabit(
                title: titleController.text,
                firstDay: selectedFirstDay,
                firstMonth: selectedFirstMonth,
                firstYear: selectedFirstYear,
                lastDay: selectedLastDay,
                lastMonth: selectedLastMonth,
                lastYear: selectedLastYear);
            context.read<MainScreenCubit>().goToTab(0);
          },
          child: const Text("Kaydet"),
        );
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
