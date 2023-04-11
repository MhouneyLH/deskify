class Utils {
  static double roundDouble(double value, int places) {
    return double.parse(value.toStringAsFixed(places));
  }

  // TODO: das hier ist noch ein bisschen broke
  static double secondsToHours(int seconds) {
    final double result = roundDouble(seconds / (60 * 60), 2);
    return result;
  }

  static int hoursToSeconds(double hours) {
    return (hours * (60 * 60)).round();
  }
}
