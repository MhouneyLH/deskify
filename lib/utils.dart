class Utils {
  static double roundDouble(double value, int places) {
    return double.parse(value.toStringAsFixed(places));
  }
}
