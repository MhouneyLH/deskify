import 'package:flutter/material.dart';

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

  static const double topOfDeskThickness = 10.0;
  static const double _footThickness = 10.0;

  @override
  State<DeskAnimation> createState() => _DeskAnimationState();
}

class _DeskAnimationState extends State<DeskAnimation> {
  late final Color deskColor = Theme.of(context).colorScheme.tertiary;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildTopOfDesk(),
        _buildFoot(isLeftFoot: true),
        _buildFoot(isLeftFoot: false),
      ],
    );
  }

  Widget _buildTopOfDesk() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: widget.deskHeight,
      child: Container(
        height: DeskAnimation.topOfDeskThickness,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: deskColor,
        ),
      ),
    );
  }

  Widget _buildFoot({required bool isLeftFoot}) {
    const double footMarginToBoundaries = 20;

    return Positioned(
      left: isLeftFoot ? footMarginToBoundaries : null,
      right: isLeftFoot ? null : footMarginToBoundaries,
      bottom: 0,
      child: Container(
        width: DeskAnimation._footThickness,
        height: widget.deskHeight,
        decoration: BoxDecoration(
          color: deskColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
