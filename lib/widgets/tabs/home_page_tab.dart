
import 'package:carousel_slider/carousel_slider.dart';
import 'package:deskify/model/desk.dart';
import 'package:deskify/pages/add_preset_page.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/provider/interaction_widget_provider.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/provider/theme_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
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
  late InteractionWidgetProvider interactionWidgetProvider;

  late List<InteractionWidget> analyticalInteractionWidgets;
  late List<InteractionWidget> presetInteractionWidgets;
  late List<InteractionWidget> otherInteractionWidgets;

  late TextEditingController deskNameController =
      getUpdatedDeskNameController();
  final CarouselController buttonCarouselController = CarouselController();

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      _initProvider();
      _initInteractionWidgets();
      deskProvider.addListener(() {
        setState(() {
          interactionWidgetProvider.initWidgets();
          deskNameController = getUpdatedDeskNameController();
        });
      });

      _isInitialized = true;
    }

    super.didChangeDependencies();
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

  TextEditingController getUpdatedDeskNameController() => TextEditingController(
        text: deskProvider.currentDesk!.name,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDeskHeading(),
        const SizedBox(width: 10.0),
        Text('Height: ${deskProvider.currentDesk!.height} cm'),
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
    void openDialog() => showDialog(
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

    return Heading(
      title: deskProvider.currentDesk!.name,
      nextToHeadingWidgets: [
        const SizedBox(width: 10.0),
        IconButton(
            onPressed: openDialog,
            icon: const Icon(Icons.edit),
            splashRadius: 20.0),
      ],
      onTapped: openDialog,
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

  void _updateDesk(int index) {
    deskProvider.currentlySelectedIndex = index;
    deskNameController = getUpdatedDeskNameController();
    interactionWidgetProvider.initWidgets();
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
}
