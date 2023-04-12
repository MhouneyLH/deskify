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
}
