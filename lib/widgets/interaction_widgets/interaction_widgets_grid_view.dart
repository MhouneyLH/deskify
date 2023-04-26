import 'package:deskify/widgets/interaction_widgets/interaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

class InteractionWidgetGridView extends StatefulWidget {
  final List<InteractionWidget> items;
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
            .map((InteractionWidget item) => _buildGridViewItem(item))
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

  Widget _buildGridViewItem(InteractionWidget item) {
    return SizedBox(
        key: ValueKey(item), width: itemWidth, height: itemHeight, child: item);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final InteractionWidget item = widget.items.removeAt(oldIndex);
      widget.items.insert(newIndex, item);
    });
  }
}
