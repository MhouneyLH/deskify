class ThemeSettings {
  bool isDarkTheme;

  ThemeSettings({required this.isDarkTheme});

  static ThemeSettings fromJson(Map<String, dynamic> json) => ThemeSettings(
        isDarkTheme: json['isDarkTheme'],
      );

  Map<String, dynamic> toJson() => {
        'isDarkTheme': isDarkTheme,
      };
}
