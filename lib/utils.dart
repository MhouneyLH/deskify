import 'package:flutter/material.dart';

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

  static int getCurrentWeekdayAsInt() {
    return DateTime.now().weekday;
  }

  static String intToShortWeekday(int dayAsInt) {
    switch (dayAsInt) {
      case DateTime.monday:
        return "Mon";
      case DateTime.tuesday:
        return "Tue";
      case DateTime.wednesday:
        return "Wed";
      case DateTime.thursday:
        return "Thu";
      case DateTime.friday:
        return "Fri";
      case DateTime.saturday:
        return "Sat";
      case DateTime.sunday:
        return "Sun";
      default:
        return "Unknown";
    }
  }

  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            message,
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }
}
