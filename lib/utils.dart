class Utils {
  static double roundDouble(double value, int places) {
    return double.parse(value.toStringAsFixed(places));
  }

  static double secondsToMinutes(int seconds) {
    return roundDouble(seconds / 60, 2);
  }

  static int minutesToSeconds(double hours) {
    return (hours * 60).round();
  }

  static String intToWeekday(int dayAsInt) {
    switch (dayAsInt) {
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      case DateTime.saturday:
        return "Saturday";
      case DateTime.sunday:
        return "Sunday";
      default:
        return "Unknown";
    }
  }
}
