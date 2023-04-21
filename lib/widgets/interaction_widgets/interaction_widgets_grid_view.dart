import 'package:deskify/widgets/interaction_widgets/simple_interaction_widget.dart';
import 'package:flutter/material.dart';

class InteractionWidgetGridView extends StatelessWidget {
  final List<SimpleInteractionWidget> items;
  final double outerDefinedSpacings;

  const InteractionWidgetGridView({
    required this.items,
    this.outerDefinedSpacings = 0.0,
    super.key,
  });

  final double itemWidth = 200.0;
  final double itemHeight = 50.0;
  final int itemsPerRow = 2;
  final double defaultSpacing = 10.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getTotalGridViewHeightWithOuterDefinedSpacing(),
      child: GridView.builder(
        // otherwise I just scroll within the GridView
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemsPerRow,
          mainAxisSpacing: defaultSpacing,
          crossAxisSpacing: defaultSpacing,
          mainAxisExtent: itemHeight,
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final SimpleInteractionWidget item = items[index];
          return SizedBox(
            width: itemWidth,
            height: itemHeight,
            child: item,
          );
        },
      ),
    );
  }

  double _getTotalGridViewHeightWithOuterDefinedSpacing() {
    final double gridHeight = itemHeight * (items.length / itemsPerRow).ceil() +
        defaultSpacing * ((items.length / itemsPerRow) - 1) +
        outerDefinedSpacings;
    return gridHeight;
  }
}
