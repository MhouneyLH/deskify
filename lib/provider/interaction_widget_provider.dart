import 'package:deskify/model/preset.dart';
import 'package:deskify/pages/analytics_widget_page.dart';
import 'package:deskify/pages/move_widget_page.dart';
import 'package:deskify/pages/preset_widget_page.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/provider/theme_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/progress_bar.dart';
import 'package:deskify/widgets/interaction_widgets/interaction_widget.dart';
import 'package:flutter/material.dart';

class InteractionWidgetProvider extends ChangeNotifier {
  BuildContext? context;
  DeskProvider? deskProvider;
  ProfileProvider? profileProvider;
  ThemeProvider? themeProvider;

  List<InteractionWidget> _analyticalInteractionWidgets = [];
  List<InteractionWidget> _presetInteractionWidgets = [];
  List<InteractionWidget> _otherInteractionWidgets = [];

  void initWidgets() {
    _analyticalInteractionWidgets = [
      InteractionWidget(
        title: 'Standing',
        icon: const Icon(Icons.info),
        extraInformationWidget: ProgressBar(
          height: 10.0,
          target: profileProvider!.todaysStandingTarget,
          displayColor: themeProvider!.standingColor,
        ),
        onPressedWholeWidget: () => Utils.navigateToWidgetPage(
          context: context!,
          title: 'Standing',
          child: AnalyticsWidgetPage(
            targetWeekdayMap: profileProvider!.standingAnalytic,
            signalizationColor: themeProvider!.standingColor,
          ),
        ),
      ),
      InteractionWidget(
        title: 'Sitting',
        icon: const Icon(Icons.info),
        extraInformationWidget: ProgressBar(
          height: 10.0,
          target: profileProvider!.todaysSittingTarget,
          displayColor: themeProvider!.sittingColor,
        ),
        onPressedWholeWidget: () => Utils.navigateToWidgetPage(
          context: context!,
          title: 'Sitting',
          child: AnalyticsWidgetPage(
            targetWeekdayMap: profileProvider!.sittingAnalytic,
            signalizationColor: themeProvider!.sittingColor,
          ),
        ),
      ),
    ];

    _presetInteractionWidgets = [
      for (Preset preset in deskProvider!.currentDesk!.presets)
        InteractionWidget(
          title: preset.title,
          icon: preset.icon,
          onPressedWholeWidget: () => deskProvider!.udpateDeskHeight(
            deskProvider!.currentDesk!,
            preset.targetHeight,
          ),
          onPressedSettingsIcon: () => Utils.navigateToWidgetPage(
            context: context!,
            title: preset.title,
            child: PresetWidgetPage(
              preset: preset,
              onAboutToPop: () => {},
              // onAboutToPop: () => presetInteractionWidgets =
              //     getUpdatedPresetInteractionWidgets(),
            ),
          ),
        ),
    ];

    _otherInteractionWidgets = [
      InteractionWidget(
        title: 'Move',
        icon: const Icon(Icons.input),
        onPressedWholeWidget: () => Utils.navigateToWidgetPage(
          context: context!,
          title: 'Moving',
          child: const MoveWidgetPage(),
        ),
      ),
    ];
  }

  List<InteractionWidget> get analyticalInteractionWidgets =>
      _analyticalInteractionWidgets;
  List<InteractionWidget>? get presetInteractionWidgets =>
      _presetInteractionWidgets;
  List<InteractionWidget> get otherInteractionWidgets =>
      _otherInteractionWidgets;

  void reorderAnalytical(int oldIndex, int newIndex) {
    final InteractionWidget item =
        _analyticalInteractionWidgets.removeAt(oldIndex);
    _analyticalInteractionWidgets.insert(newIndex, item);

    notifyListeners();
  }

  void reorderPreset(int oldIndex, int newIndex) {
    final InteractionWidget item = _presetInteractionWidgets.removeAt(oldIndex);
    _presetInteractionWidgets.insert(newIndex, item);

    notifyListeners();
  }

  void reorderOther(int oldIndex, int newIndex) {
    final InteractionWidget item = _otherInteractionWidgets.removeAt(oldIndex);
    _otherInteractionWidgets.insert(newIndex, item);

    notifyListeners();
  }
}
