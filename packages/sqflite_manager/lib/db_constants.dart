String dbName = "HabitsTracker.db";

class Tables {
  static const String habit = "Habit";
  static const String dates = "Dates";
}

class HabitFields {
  static const String title = "title";
  static const String id = "id";
  static const String startDate = "startDate";
  static const String dueTime = "dueTime";
  static const String howLongItWillTake = "howLongItWillTake";
  static const String isActive = "isActive";
  static const String dates = "dates";
}

class DateFields {
  static const String dateId = "dateId";
  static const String id = "id";
  static const String isDone = "isDone";
  static const String date = "date";
}
