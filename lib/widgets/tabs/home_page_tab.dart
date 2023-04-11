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
  DeskProvider? deskProvider;
  ProfileProvider? profileProvider;

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);

    final List<SimpleInteractionWidget> analyticInteractionWidgets = [
      SimpleInteractionWidget(
        title: "Standing Information",
        icon: const Icon(Icons.info),
        onPressed: () => _navigateToWidgetPage(
          context,
          AnalyticsWidgetPage(
            target: profileProvider!.standingTimeTarget!,
            signalizationColor: Colors.green,
          ),
        ),
      ),
      SimpleInteractionWidget(
        title: "Sitting Information",
        icon: const Icon(Icons.info),
        onPressed: () => _navigateToWidgetPage(
          context,
          AnalyticsWidgetPage(
            target: profileProvider!.sittingTimeTarget!,
            signalizationColor: Colors.red,
          ),
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(title: deskProvider!.name),
        Text("Height: ${deskProvider!.height} cm"),
        Icon(profileProvider!.image.icon),
        Text(profileProvider!.name!),
        Text(profileProvider!.email!),
        Text(profileProvider!.password!),
        Text("${profileProvider!.standingTimeTarget!.targetValue} h"),
        Text("${profileProvider!.standingTimeTarget!.actualValue} h"),
        Text("${profileProvider!.sittingTimeTarget!.targetValue} h"),
        Text("${profileProvider!.sittingTimeTarget!.actualValue} h"),
        Text(profileProvider!.id),
        _buildDeskAnimation(),
        _buildInteractiveWidgetGroup(analyticInteractionWidgets, "Analytics"),
        _buildInteractiveWidgetGroup(presetInteractionWidgets, "Presets"),
        _buildInteractiveWidgetGroup(otherInteractionWidgets, "Others"),
      ],
    );
  }

  Future<dynamic> _navigateToWidgetPage(BuildContext context, Widget widget) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => widget,
      ),
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
