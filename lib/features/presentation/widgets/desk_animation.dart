import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

/// A widget that displays a desk with a given height.
///
/// The desk is displayed as a stack of a desk display and two feet.
class DeskAnimation extends StatefulWidget {
  final double width;
  final double deskHeight;

  const DeskAnimation({
    required this.width,
    required this.deskHeight,
    super.key,
  });

  @override
  State<DeskAnimation> createState() => _DeskAnimationState();
}

class _DeskAnimationState extends State<DeskAnimation> {
  late double deskDisplayHeight;
  final double deskDisplayThickness = 10.0;
  late Color deskColor;

  @override
  Widget build(BuildContext context) {
    deskDisplayHeight = widget.deskHeight;
    deskColor = Theme.of(context).colorScheme.tertiary;

    return SizedBox(
      width: widget.width,
      height: deskMaximumHeight + deskDisplayThickness,
      child: Stack(
        children: [
          _buildDesk(),
          _buildFoot(isLeftFoot: true),
          _buildFoot(isLeftFoot: false),
        ],
      ),
    );
  }

  Widget _buildDesk() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: deskDisplayHeight,
      child: Container(
        height: deskDisplayThickness,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: deskColor,
        ),
      ),
    );
  }

  Widget _buildFoot({required bool isLeftFoot}) {
    final double footMarginToBoundaries = widget.width / 8;

    return Positioned(
      left: isLeftFoot ? footMarginToBoundaries : null,
      right: isLeftFoot ? null : footMarginToBoundaries,
      bottom: 0,
      child: Container(
        width: 10,
        height: deskDisplayHeight,
        decoration: BoxDecoration(
          color: deskColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
