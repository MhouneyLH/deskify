import 'package:deskify/pages/move_widget_page.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/widgets/generic/heading_widget.dart';
import 'package:deskify/widgets/interaction_widgets/interaction_widgets_grid_view.dart';
import 'package:deskify/widgets/interaction_widgets/simple_interaction_widget.dart';
import 'package:deskify/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  final double spacing = 10.0;

  List<SimpleInteractionWidget>? analyticInteractionWidgets;
  List<SimpleInteractionWidget>? presetInteractionWidgets;
  List<SimpleInteractionWidget>? otherInteractionWidgets;

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

  void _initInteractionWidgets() {
    analyticInteractionWidgets = const [
      SimpleInteractionWidget(
          title: "Standing Information", icon: Icon(Icons.info)),
      SimpleInteractionWidget(
          title: "Sitting Information", icon: Icon(Icons.info)),
    ];

    presetInteractionWidgets = const [
      SimpleInteractionWidget(title: "Preset 1", icon: Icon(Icons.input)),
      SimpleInteractionWidget(title: "Preset 2", icon: Icon(Icons.input)),
      SimpleInteractionWidget(title: "Preset 3", icon: Icon(Icons.input)),
    ];

    otherInteractionWidgets = [
      SimpleInteractionWidget(
        title: "Move",
        icon: const Icon(Icons.input),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const MoveWidgetPage(),
          ),
        ),
      ),
    ];
  }

  SizedBox _buildDeskAnimation() {
    return const SizedBox(
      height: 150,
      width: 150,
      child: MyAnimatedWidget(),
    );
  }

  @override
  void initState() {
    super.initState();
    _initInteractionWidgets();
  }

  @override
  Widget build(BuildContext context) {
    final DeskProvider deskProvider = Provider.of<DeskProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Heading(title: "$deskProvider.name"),
          Text("Height: ${deskProvider.height} cm"),
          _buildDeskAnimation(),
          _getInteractiveWidgetGroup(analyticInteractionWidgets!, "Analytics"),
          _getInteractiveWidgetGroup(presetInteractionWidgets!, "Presets"),
          _getInteractiveWidgetGroup(otherInteractionWidgets!, "Others"),
        ],
      ),
    );
  }
}
