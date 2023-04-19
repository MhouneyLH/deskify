import 'package:deskify/main.dart';
import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/pages/analytics_widget_page.dart';
import 'package:deskify/pages/move_widget_page.dart';
import 'package:deskify/pages/preset_widget_page.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/provider/theme_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:deskify/widgets/generic/progress_bar.dart';
import 'package:deskify/widgets/interaction_widgets/interaction_widgets_grid_view.dart';
import 'package:deskify/widgets/interaction_widgets/simple_interaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  late DeskProvider deskProvider;
  late Desk currentDesk;
  late ProfileProvider profileProvider;
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    currentDesk = deskProvider.currentDesk;
    profileProvider = Provider.of<ProfileProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);

    final List<SimpleInteractionWidget> analyticInteractionWidgets = [
      SimpleInteractionWidget(
        title: "Standing Information",
        icon: const Icon(Icons.info),
        extraInformationWidget: ProgressBar(
          height: 10.0,
          progressValue: profileProvider.todaysStandingTarget.actualValue /
              Utils.minutesToSeconds(
                  profileProvider.todaysStandingTarget.targetValue),
          displayColor: themeProvider.darkStandingColor,
        ),
        onPressedWholeWidget: () => _navigateToWidgetPage(
          context,
          AnalyticsWidgetPage(
            targetWeekdayMap: profileProvider.standingAnalytic,
            signalizationColor: themeProvider.darkStandingColor,
          ),
        ),
      ),
      SimpleInteractionWidget(
        title: "Sitting Information",
        icon: const Icon(Icons.info),
        extraInformationWidget: ProgressBar(
          height: 10.0,
          progressValue: profileProvider.todaysSittingTarget.actualValue /
              Utils.minutesToSeconds(
                  profileProvider.todaysSittingTarget.targetValue),
          displayColor: themeProvider.darkSittingColor,
        ),
        onPressedWholeWidget: () => _navigateToWidgetPage(
          context,
          AnalyticsWidgetPage(
            targetWeekdayMap: profileProvider.sittingAnalytic,
            signalizationColor: themeProvider.darkSittingColor,
          ),
        ),
      ),
    ];

    final List<SimpleInteractionWidget> presetInteractionWidgets = [
      for (Preset preset in currentDesk.presets!)
        SimpleInteractionWidget(
          title: preset.title,
          icon: preset.icon,
          onPressedWholeWidget: () => currentDesk.height = preset.targetHeight,
          onPressedSettingsIcon: () => _navigateToWidgetPage(
            context,
            PresetWidgetPage(preset: preset),
          ),
        ),
    ];

    final List<SimpleInteractionWidget> otherInteractionWidgets = [
      SimpleInteractionWidget(
        title: "Move",
        icon: const Icon(Icons.input),
        onPressedWholeWidget: () => _navigateToWidgetPage(
          context,
          const MoveWidgetPage(),
        ),
      ),
    ];

    // TODO: see later, if that is really working
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Heading(title: currentDesk.name!),
          Text("Height: ${currentDesk.height} cm"),
          const SizedBox(height: 10.0),
          _buildDeskAnimation(),
          _buildInteractiveWidgetGroup(analyticInteractionWidgets, "Analytics"),
          _buildInteractiveWidgetGroup(presetInteractionWidgets, "Presets"),
          _buildInteractiveWidgetGroup(otherInteractionWidgets, "Others"),
        ],
      ),
    );
  }

  Future<dynamic> _navigateToWidgetPage(BuildContext context, Widget widget) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(MainApp.title),
          ),
          body: widget,
        ),
      ),
    );
  }

  Widget _buildDeskAnimation() {
    return Center(
      child: DeskAnimation(
        width: 200,
        deskHeight: currentDesk.height!,
      ),
    );
  }

  Widget _buildInteractiveWidgetGroup(
      List<SimpleInteractionWidget> items, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Heading(title: title),
        const SizedBox(height: 10.0),
        InteractionWidgetGridView(
          items: items,
          outerDefinedSpacings: 10.0,
        ),
      ],
    );
  }
}
