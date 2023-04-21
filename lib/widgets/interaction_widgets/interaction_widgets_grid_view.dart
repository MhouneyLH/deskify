import 'package:deskify/widgets/interaction_widgets/simple_interaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

class InteractionWidgetGridView extends StatefulWidget {
  final List<SimpleInteractionWidget> items;
  final double outerDefinedSpacings;

  const InteractionWidgetGridView({
    required this.items,
    this.outerDefinedSpacings = 0.0,
    super.key,
  });

  @override
  State<InteractionWidgetGridView> createState() =>
      _InteractionWidgetGridViewState();
}

class _InteractionWidgetGridViewState extends State<InteractionWidgetGridView> {
  final double itemWidth = 200.0;
  final double itemHeight = 50.0;
  final int itemsPerRow = 2;
  final double defaultSpacing = 10.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getTotalGridViewHeightWithOuterDefinedSpacing(),
      child: ReorderableGridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemsPerRow,
          mainAxisSpacing: defaultSpacing,
          crossAxisSpacing: defaultSpacing,
          mainAxisExtent: itemHeight,
        ),
        children: widget.items
            .map(
              (item) => Container(
                key: ValueKey(item),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.none,
                width: itemWidth,
                height: itemHeight,
                child: item,
              ),
            )
            .toList(),
        onReorder: (int oldIndex, int newIndex) =>
            _onReorder(oldIndex, newIndex),
      ),
    );
  }

  double _getTotalGridViewHeightWithOuterDefinedSpacing() {
    final double gridHeight =
        itemHeight * (widget.items.length / itemsPerRow).ceil() +
            defaultSpacing * ((widget.items.length / itemsPerRow) - 1) +
            widget.outerDefinedSpacings;
    return gridHeight;
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final SimpleInteractionWidget item = widget.items.removeAt(oldIndex);
      widget.items.insert(newIndex, item);
    });
  }
}
