import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/desk.dart';
import '../../pages/add_preset_page.dart';
import '../../provider/desk_provider.dart';
import '../../provider/interaction_widget_provider.dart';
import '../../provider/profile_provider.dart';
import '../../provider/theme_provider.dart';
import '../../utils.dart';
import '../generic/desk_animation.dart';
import '../generic/heading_widget.dart';
import '../generic/single_value_alert_dialog.dart';
import '../interaction_widgets/interaction_widget.dart';
import '../interaction_widgets/interaction_widgets_grid_view.dart';

// tab for displaying the home page -> acts as overview and main part of the app
// contains the desk animation and the interaction widgets
// editable is:
// - desk name
// - currently selected desk via Carousel Slider
// - order of the interaction widgets
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
  late InteractionWidgetProvider interactionWidgetProvider;

  late List<InteractionWidget> analyticalInteractionWidgets;
  late List<InteractionWidget> presetInteractionWidgets;
  late List<InteractionWidget> otherInteractionWidgets;

  late TextEditingController deskNameController =
      TextEditingController(text: deskProvider.currentDesk!.name);
  final CarouselController buttonCarouselController = CarouselController();

  @override
  void didChangeDependencies() {
    // providers has to be initialized here, because the context is needed
    // is possible with listen: false when initializing the providers
    // but this would disable the listeners
    // providers + widgets only should be initialized once
    // (otherwise e. g. the dragging of interactionWidgets don't work, as it would update the ui every frame)
    if (!_isInitialized) {
      _initProvider();
      _initInteractionWidgets();
      deskProvider.addListener(() => interactionWidgetProvider.initWidgets());

      _isInitialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDeskHeading(),
        const SizedBox(width: 10.0),
        Text(
            'Height: ${deskProvider.currentDesk!.height} ${Desk.heightMetric}'),
        const SizedBox(height: 10.0),
        _buildCarouselDeskAnimation(),
        _buildInteractiveWidgetGroup(
          items: interactionWidgetProvider.analyticalInteractionWidgets,
          onReorder: (oldIndex, newIndex) =>
              interactionWidgetProvider.reorderAnalytical(oldIndex, newIndex),
          itemHeight: 65,
          title: 'Analytics',
        ),
        _buildInteractiveWidgetGroup(
          items: interactionWidgetProvider.presetInteractionWidgets!,
          onReorder: (oldIndex, newIndex) =>
              interactionWidgetProvider.reorderPreset(oldIndex, newIndex),
          title: 'Presets',
          nextToHeadingWidgets: [
            const SizedBox(width: 5.0),
            _buildAddPresetButton(),
          ],
        ),
        _buildInteractiveWidgetGroup(
          items: interactionWidgetProvider.otherInteractionWidgets,
          onReorder: (oldIndex, newIndex) =>
              interactionWidgetProvider.reorderOther(oldIndex, newIndex),
          title: 'Others',
        ),
      ],
    );
  }

  Widget _buildDeskHeading() {
    return Heading(
      title: deskProvider.currentDesk!.name,
      nextToHeadingWidgets: [
        const SizedBox(width: 10.0),
        IconButton(
            onPressed: _openDeskNameDialog,
            icon: const Icon(Icons.edit),
            splashRadius: 20.0),
      ],
      onTapped: _openDeskNameDialog,
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
        for (Desk desk in deskProvider.desks) _buildDeskAnimation(desk),
      ],
    );
  }

  Widget _buildDeskAnimation(Desk desk) {
    return Center(
      child: DeskAnimation(
        width: 200,
        deskHeight: desk.height,
      ),
    );
  }

  Widget _buildIndicatorBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: deskProvider.desks.asMap().entries.map(
        (entry) {
          return GestureDetector(
            onTap: () => buttonCarouselController.animateToPage(entry.key),
            child: Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).colorScheme.secondary).withOpacity(
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
    required void Function(int oldIndex, int newIndex) onReorder,
    double itemHeight = 50.0,
    List<Widget>? nextToHeadingWidgets,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(title: title, nextToHeadingWidgets: nextToHeadingWidgets),
        const SizedBox(height: 10.0),
        InteractionWidgetGridView(
          items: items,
          itemHeight: itemHeight,
          onReorder: onReorder,
          outerDefinedSpacings: 10.0,
        ),
      ],
    );
  }

  Widget _buildAddPresetButton() {
    return IconButton(
      icon: const Icon(Icons.add),
      padding: const EdgeInsets.all(0.0),
      splashRadius: 20.0,
      onPressed: () => Utils.navigateToWidgetPage(
        context: context,
        title: 'Add Preset',
        child: AddPresetPage(
          onAboutToPop: () => {},
        ),
      ),
    );
  }

  void _initProvider() {
    deskProvider = Provider.of<DeskProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);
    interactionWidgetProvider = Provider.of<InteractionWidgetProvider>(context);
  }

  void _initInteractionWidgets() {
    interactionWidgetProvider.context = context;
    interactionWidgetProvider.deskProvider = deskProvider;
    interactionWidgetProvider.profileProvider = profileProvider;
    interactionWidgetProvider.themeProvider = themeProvider;
    interactionWidgetProvider.initWidgets();
  }

  void _openDeskNameDialog() => showDialog(
        context: context,
        builder: (_) => SingleValueAlertDialog(
          title: 'Edit desk name',
          controller: deskNameController,
          onSave: () => deskProvider.udpateDeskName(
            deskProvider.currentDesk!,
            deskNameController.text,
          ),
          onCancel: () =>
              deskNameController.text = deskProvider.currentDesk!.name,
        ),
      );

  void _updateDesk(int index) {
    deskProvider.currentlySelectedIndex = index;
    deskNameController.text = deskProvider.currentDesk!.name;
    interactionWidgetProvider.initWidgets();
  }
}
