import 'package:flutter/material.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import 'interaction_widget.dart';

// reorderable (interactionWidgets are draggable) grid view for a group of interaction widgets
// scrolling the grid view is disabled
class InteractionWidgetGridView extends StatefulWidget {
  final List<InteractionWidget> items;
  final double itemHeight;
  final double outerDefinedSpacings;
  final void Function(int oldIndex, int newIndex) onReorder;

  const InteractionWidgetGridView({
    required this.items,
    required this.itemHeight,
    this.outerDefinedSpacings = 0.0,
    super.key,
    required this.onReorder,
  });

  @override
  State<InteractionWidgetGridView> createState() =>
      _InteractionWidgetGridViewState();
}

class _InteractionWidgetGridViewState extends State<InteractionWidgetGridView> {
  final int _itemsPerRow = 2;
  final double _defaultSpacing = 10.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getTotalGridViewHeightWithOuterDefinedSpacing(),
      child: ReorderableGridView(
        // otherwise the grid view is scrollable
        // -> User could not scroll the page properly
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: _buildGridDelegate(),
        children: widget.items
            .map((InteractionWidget item) => _buildGridViewItem(item))
            .toList(),
        onReorder: (int oldIndex, int newIndex) =>
            widget.onReorder(oldIndex, newIndex),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _buildGridDelegate() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: _itemsPerRow,
      mainAxisSpacing: _defaultSpacing,
      crossAxisSpacing: _defaultSpacing,
      mainAxisExtent: widget.itemHeight,
    );
  }

  Widget _buildGridViewItem(InteractionWidget item) {
    return Container(
      key: ValueKey(item),
      child: item,
    );
  }

  // has to calculate the height of the whole grid view myself
  // otherwise the grid view is too small and the widgets are not properly visible
  double _getTotalGridViewHeightWithOuterDefinedSpacing() {
    final double gridHeight =
        widget.itemHeight * (widget.items.length / _itemsPerRow).ceil() +
            _defaultSpacing * ((widget.items.length / _itemsPerRow) - 1) +
            widget.outerDefinedSpacings;
    return gridHeight;
  }
}
