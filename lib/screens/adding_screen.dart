import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:make_habits/cubit/cubits.dart';

final days = List<String>.generate(31, (i) => (i + 1).toString());
final months = List<String>.generate(12, (i) => (i + 1).toString());
final years = List<String>.generate(12, (i) => (i + 2022).toString());

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
      )..emitDate(
          selectedFirstDay: DateTime.now().day.toString(),
          selectedFirstMonth: DateTime.now().month.toString(),
          selectedFirstYear: DateTime.now().year.toString(),
          selectedLastDay: DateTime.now().day.toString(),
          selectedLastMonth: DateTime.now().month.toString(),
          selectedLastYear: DateTime.now().year.toString(),
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
  final titleController = TextEditingController();

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
            onEditingComplete: () => context
                .read<AddHabitCubit>()
                .emitDate(title: titleController.text),
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

class _FirstDaySelector extends StatelessWidget {
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
          value: state.selectedFirstDay,
          items: days.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: (String? value) =>
              context.read<AddHabitCubit>().emitDate(selectedFirstDay: value),
        );
      },
    );
  }
}

class _FirstMonthSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddHabitCubit, AddHabitState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: state.selectedFirstMonth,
          items: months.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: (String? value) =>
              context.read<AddHabitCubit>().emitDate(selectedFirstMonth: value),
        );
      },
    );
  }
}

class _FirstYearSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddHabitCubit, AddHabitState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: state.selectedFirstYear,
          items: years.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: (String? value) =>
              context.read<AddHabitCubit>().emitDate(selectedFirstYear: value),
        );
      },
    );
  }
}

class _LastDaySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddHabitCubit, AddHabitState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: state.selectedLastDay,
          items: days.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: (String? value) =>
              context.read<AddHabitCubit>().emitDate(selectedLastDay: value),
        );
      },
    );
  }
}

class _LastMonthSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddHabitCubit, AddHabitState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: state.selectedLastMonth,
          items: months.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: (String? value) =>
              context.read<AddHabitCubit>().emitDate(selectedLastMonth: value),
        );
      },
    );
  }
}

class _LastYearSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddHabitCubit, AddHabitState>(
      builder: (context, state) {
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          value: state.selectedLastYear,
          items: years.map((e) {
            return DropdownMenuItem(value: e, child: Text(e.toString()));
          }).toList(),
          onChanged: (String? value) =>
              context.read<AddHabitCubit>().emitDate(selectedLastYear: value),
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
            context.read<AddHabitCubit>().addHabit();
            context.read<MainScreenCubit>().goToTab(0);
          },
          child: const Text("Kaydet"),
        );
      },
    );
  }
}
