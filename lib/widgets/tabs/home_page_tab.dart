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
import 'package:deskify/widgets/interaction_widgets/interaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  bool _isInitialized = false;

  late DeskProvider deskProvider;
  late ProfileProvider profileProvider;
  late ThemeProvider themeProvider;

  late List<InteractionWidget> analyticalInteractionWidgets;
  late List<InteractionWidget> presetInteractionWidgets;
  late List<InteractionWidget> otherInteractionWidgets;

  late final Desk currentDesk = deskProvider.currentDesk;
  late final TextEditingController deskNameController =
      TextEditingController(text: currentDesk.name);

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      _init();
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  void _init() {
    _initProvider();
    _initWidgets();
    setState(() {}); // Trigger a rebuild to update the UI
  }

  void _initProvider() {
    deskProvider = Provider.of<DeskProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);
  }

  void _initWidgets() {
    analyticalInteractionWidgets = [
      InteractionWidget(
        title: "Standing Information",
        icon: const Icon(Icons.info),
        extraInformationWidget: ProgressBar(
          height: 10.0,
          progressValue: profileProvider.todaysStandingTarget.actualValue /
              Utils.minutesToSeconds(
                  profileProvider.todaysStandingTarget.targetValue),
          displayColor: themeProvider.darkStandingColor,
        ),
        onPressedWholeWidget: () => Utils.navigateToWidgetPage(
          context: context,
          title: "Standing Information",
          child: AnalyticsWidgetPage(
            targetWeekdayMap: profileProvider.standingAnalytic,
            signalizationColor: themeProvider.darkStandingColor,
          ),
        ),
      ),
      InteractionWidget(
        title: "Sitting Information",
        icon: const Icon(Icons.info),
        extraInformationWidget: ProgressBar(
          height: 10.0,
          progressValue: profileProvider.todaysSittingTarget.actualValue /
              Utils.minutesToSeconds(
                  profileProvider.todaysSittingTarget.targetValue),
          displayColor: themeProvider.darkSittingColor,
        ),
        onPressedWholeWidget: () => Utils.navigateToWidgetPage(
          context: context,
          title: "Sitting Information",
          child: AnalyticsWidgetPage(
            targetWeekdayMap: profileProvider.sittingAnalytic,
            signalizationColor: themeProvider.darkSittingColor,
          ),
        ),
      ),
    ];

    presetInteractionWidgets = [
      for (Preset preset in currentDesk.presets!)
        InteractionWidget(
          title: preset.title,
          icon: preset.icon,
          onPressedWholeWidget: () => currentDesk.height = preset.targetHeight,
          onPressedSettingsIcon: () => Utils.navigateToWidgetPage(
            context: context,
            title: preset.title,
            child: PresetWidgetPage(preset: preset),
          ),
        ),
    ];

    otherInteractionWidgets = [
      InteractionWidget(
        title: "Move",
        icon: const Icon(Icons.input),
        onPressedWholeWidget: () => Utils.navigateToWidgetPage(
          context: context,
          title: "Moving",
          child: const MoveWidgetPage(),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(
          title: currentDesk.name!,
          onTapped: () => showDialog(
            context: context,
            builder: (_) => _buildHeadingAlertDialog(),
          ),
        ),
        const SizedBox(width: 10.0),
        Text("Height: ${currentDesk.height} cm"),
        const SizedBox(height: 10.0),
        _buildDeskAnimation(),
        _buildInteractiveWidgetGroup(analyticalInteractionWidgets, "Analytics"),
        _buildInteractiveWidgetGroup(presetInteractionWidgets, "Presets"),
        _buildInteractiveWidgetGroup(otherInteractionWidgets, "Others"),
      ],
    );
  }

  Widget _buildHeadingAlertDialog() {
    return AlertDialog(
      title: const Text('Edit desk name'),
      content: TextField(controller: deskNameController),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            deskNameController.text = currentDesk.name!;
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              currentDesk.name = deskNameController.text;
            });
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
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
      List<InteractionWidget> items, String title) {
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
