import 'package:deskify/widgets/interaction_widgets/simple_interaction_widget.dart';
import 'package:flutter/material.dart';

class InteractionWidgetGridView extends StatelessWidget {
  final List<SimpleInteractionWidget>? items;
  final double? outerDefinedSpacings;

  const InteractionWidgetGridView({
    @required this.items,
    this.outerDefinedSpacings = 0.0,
    super.key,
  });

  final double itemWidth = 200.0;
  final double itemHeight = 50.0;
  final int itemsPerRow = 2;

  double _getGridViewHeight() {
    final double gridHeight =
        itemHeight * (items!.length / itemsPerRow).ceil() +
            10 * ((items!.length / itemsPerRow) - 1) +
            outerDefinedSpacings!;
    return gridHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getGridViewHeight(),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemsPerRow,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          mainAxisExtent: itemHeight,
        ),
        itemCount: items!.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items![index];
          return SizedBox(
            width: itemWidth,
            height: itemHeight,
            child: item,
          );
        },
      ),
    );
  }
}
