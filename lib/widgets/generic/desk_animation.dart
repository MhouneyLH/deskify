import 'package:deskify/model/desk.dart';
import 'package:flutter/material.dart';

class DeskAnimation extends StatefulWidget {
  final double width;
  final double deskHeight;

  const DeskAnimation({
    this.width = 200.0,
    required this.deskHeight,
    super.key,
  });

  @override
  State<DeskAnimation> createState() => _DeskAnimationState();
}

class _DeskAnimationState extends State<DeskAnimation> {
  late double deskDisplayHeight;
  final double deskDisplayThickness = 10.0;

  @override
  Widget build(BuildContext context) {
    deskDisplayHeight =
        (widget.deskHeight / Desk.maximumHeight) * Desk.maximumHeight;

    return SizedBox(
      width: widget.width,
      height: Desk.maximumHeight + deskDisplayThickness,
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
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10),
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
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
