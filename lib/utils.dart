class Utils {
  static double roundDouble(double value, int places) {
    return double.parse(value.toStringAsFixed(places));
  }

  // TODO: am besten einfach von Sekunden zu Minuten und umgekehrt
  static double secondsToHours(int seconds) {
    final double result = roundDouble(seconds / (60 * 60), 2);
    return result;
  }

// TODO: am besten einfach von Sekunden zu Minuten und umgekehrt
  static int hoursToSeconds(double hours) {
    return (hours * (60 * 60)).round();
  }
}
