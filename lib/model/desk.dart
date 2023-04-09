class Desk {
  String? name;
  double? height;

  static const double minimumHeight = 72.0;
  static const double maximumHeight = 119.0;

  Desk({
    this.name = "Deskified Desk",
    this.height = minimumHeight,
  });
}
