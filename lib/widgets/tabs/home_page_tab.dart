import 'package:carousel_slider/carousel_slider.dart';
import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/pages/add_preset_page.dart';
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
import 'package:deskify/widgets/generic/single_value_alert_dialog.dart';
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

  late TextEditingController deskNameController = updatedDeskNameController;
  final CarouselController buttonCarouselController = CarouselController();

  late List<InteractionWidget> analyticalInteractionWidgets = [
    InteractionWidget(
      title: 'Standing',
      icon: const Icon(Icons.info),
      extraInformationWidget: ProgressBar(
        height: 10.0,
        target: profileProvider.todaysStandingTarget,
        displayColor: themeProvider.darkStandingColor,
      ),
      onPressedWholeWidget: () => Utils.navigateToWidgetPage(
        context: context,
        title: 'Standing',
        child: AnalyticsWidgetPage(
          targetWeekdayMap: profileProvider.standingAnalytic,
          signalizationColor: themeProvider.darkStandingColor,
        ),
      ),
    ),
    InteractionWidget(
      title: 'Sitting',
      icon: const Icon(Icons.info),
      extraInformationWidget: ProgressBar(
        height: 10.0,
        target: profileProvider.todaysSittingTarget,
        displayColor: themeProvider.darkSittingColor,
      ),
      onPressedWholeWidget: () => Utils.navigateToWidgetPage(
        context: context,
        title: 'Sitting',
        child: AnalyticsWidgetPage(
          targetWeekdayMap: profileProvider.sittingAnalytic,
          signalizationColor: themeProvider.darkSittingColor,
        ),
      ),
    ),
  ];
  late List<InteractionWidget> presetInteractionWidgets =
      updatedPresetInteractionWidgets;
  late List<InteractionWidget> otherInteractionWidgets = [
    InteractionWidget(
      title: 'Move',
      icon: const Icon(Icons.input),
      onPressedWholeWidget: () => Utils.navigateToWidgetPage(
        context: context,
        title: 'Moving',
        child: const MoveWidgetPage(),
      ),
    ),
  ];

  TextEditingController get updatedDeskNameController => TextEditingController(
        text: deskProvider.currentDesk.name,
      );

  List<InteractionWidget> get updatedPresetInteractionWidgets => [
        for (Preset preset in deskProvider.currentDesk.presets!)
          InteractionWidget(
            title: preset.title,
            icon: preset.icon,
            onPressedWholeWidget: () =>
                deskProvider.currentDesk.height = preset.targetHeight,
            onPressedSettingsIcon: () => Utils.navigateToWidgetPage(
              context: context,
              title: preset.title,
              child: PresetWidgetPage(
                preset: preset,
                onAboutToPop: () =>
                    presetInteractionWidgets = updatedPresetInteractionWidgets,
              ),
            ),
          ),
      ];

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      _initProvider();
      _isInitialized = true;
    }

    super.didChangeDependencies();
  }

  void _initProvider() {
    deskProvider = Provider.of<DeskProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDeskHeading(),
        const SizedBox(width: 10.0),
        Text('Height: ${deskProvider.currentDesk.height} cm'),
        const SizedBox(height: 10.0),
        _buildCarouselDeskAnimation(),
        _buildInteractiveWidgetGroup(
          items: analyticalInteractionWidgets,
          itemHeight: 65,
          title: 'Analytics',
        ),
        _buildInteractiveWidgetGroup(
          items: presetInteractionWidgets,
          title: 'Presets',
          nextToHeadingWidgets: [
            _buildAddPresetButton(),
          ],
        ),
        _buildInteractiveWidgetGroup(
          items: otherInteractionWidgets,
          title: 'Others',
        ),
      ],
    );
  }

  Widget _buildDeskHeading() {
    return Heading(
      title: deskProvider.currentDesk.name!,
      onTapped: () => showDialog(
        context: context,
        builder: (_) => SingleValueAlertDialog(
          title: 'Edit desk name',
          controller: deskNameController,
          onSave: () => deskProvider.currentDesk.name = deskNameController.text,
          onCancel: () =>
              deskNameController.text = deskProvider.currentDesk.name!,
        ),
      ),
    );
  }

  Widget _buildCarouselDeskAnimation() {
    return Column(
      children: [
        _buildCarousel(),
        _buildIndicatorBar(),
      ],
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        height: 200.0,
        enableInfiniteScroll: false,
        initialPage: deskProvider.currentlySelectedIndex,
        onPageChanged: (index, _) => _updateDesk(index),
      ),
      items: [
        for (Desk desk in deskProvider.deskList) _buildDeskAnimation(desk),
      ],
    );
  }

  void _updateDesk(int index) {
    deskProvider.currentlySelectedIndex = index;
    presetInteractionWidgets = updatedPresetInteractionWidgets;
    deskNameController = updatedDeskNameController;
  }

  Widget _buildDeskAnimation(Desk desk) {
    return Center(
      child: DeskAnimation(
        width: 200,
        deskHeight: desk.height!,
      ),
    );
  }

  Widget _buildIndicatorBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: deskProvider.deskList.asMap().entries.map(
        (entry) {
          return GestureDetector(
            onTap: () => buttonCarouselController.animateToPage(entry.key),
            child: Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).accentColor).withOpacity(
                    deskProvider.currentlySelectedIndex == entry.key
                        ? 0.9
                        : 0.3),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildInteractiveWidgetGroup({
    required String title,
    required List<InteractionWidget> items,
    double itemHeight = 50.0,
    List<Widget>? nextToHeadingWidgets,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Heading(title: title),
            const SizedBox(width: 5.0),
            if (nextToHeadingWidgets != null) ...nextToHeadingWidgets,
          ],
        ),
        const SizedBox(height: 10.0),
        InteractionWidgetGridView(
          items: items,
          itemHeight: itemHeight,
          outerDefinedSpacings: 10.0,
        ),
      ],
    );
  }

  Widget _buildAddPresetButton() {
    return SizedBox(
      width: 20.0,
      height: 20.0,
      child: IconButton(
        icon: const Icon(Icons.add),
        padding: const EdgeInsets.all(0.0),
        splashRadius: 20.0,
        onPressed: () => Utils.navigateToWidgetPage(
          context: context,
          title: 'Add Preset',
          child: AddPresetPage(
            onAboutToPop: () =>
                presetInteractionWidgets = updatedPresetInteractionWidgets,
          ),
        ),
      ),
    );
  }
}
