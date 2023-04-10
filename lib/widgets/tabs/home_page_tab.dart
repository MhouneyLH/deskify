import 'package:deskify/model/desk.dart';
import 'package:deskify/model/preset.dart';
import 'package:deskify/pages/analytics_widget_page.dart';
import 'package:deskify/pages/move_widget_page.dart';
import 'package:deskify/pages/preset_widget_page.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/widgets/generic/desk_animation.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
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
  final double spacing = 10.0;
  DeskProvider? deskProvider;

  Future<dynamic> _navigateToWidgetPage(BuildContext context, Widget widget) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  Widget _getInteractiveWidgetGroup(
      List<SimpleInteractionWidget> items, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Heading(title: title),
        SizedBox(height: spacing),
        InteractionWidgetGridView(
          items: items,
          outerDefinedSpacings: spacing,
        ),
      ],
    );
  }

  Widget _buildDeskAnimation() {
    return Center(
      child: DeskAnimation(
        width: 200,
        height: Desk.minimumHeight,
        deskHeight: deskProvider!.height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context);

    final List<SimpleInteractionWidget> analyticInteractionWidgets = [
      SimpleInteractionWidget(
        title: "Standing Information",
        icon: const Icon(Icons.info),
        onPressed: () => _navigateToWidgetPage(
          context,
          const AnalyticsWidgetPage(),
        ),
      ),
      SimpleInteractionWidget(
        title: "Sitting Information",
        icon: const Icon(Icons.info),
        onPressed: () => _navigateToWidgetPage(
          context,
          const AnalyticsWidgetPage(),
        ),
      ),
    ];

    final List<SimpleInteractionWidget> presetInteractionWidgets = [
      for (Preset preset in deskProvider!.presets)
        SimpleInteractionWidget(
          title: preset.title,
          icon: preset.icon,
          onPressed: () => _navigateToWidgetPage(
            context,
            PresetWidgetPage(preset: preset),
          ),
        ),
    ];

    final List<SimpleInteractionWidget> otherInteractionWidgets = [
      SimpleInteractionWidget(
        title: "Move",
        icon: const Icon(Icons.input),
        onPressed: () => _navigateToWidgetPage(
          context,
          const MoveWidgetPage(),
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Heading(title: deskProvider!.name),
          Text("Height: ${deskProvider!.height} cm"),
          Icon(profileProvider.image.icon),
          Text(profileProvider.name!),
          Text(profileProvider.email!),
          Text(profileProvider.password!),
          Text("${profileProvider.standingTarget!.targetValue} h"),
          Text("${profileProvider.sittingTarget!.targetValue} h"),
          Text(profileProvider.id),
          _buildDeskAnimation(),
          _getInteractiveWidgetGroup(analyticInteractionWidgets, "Analytics"),
          _getInteractiveWidgetGroup(presetInteractionWidgets, "Presets"),
          _getInteractiveWidgetGroup(otherInteractionWidgets, "Others"),
        ],
      ),
    );
  }
}
