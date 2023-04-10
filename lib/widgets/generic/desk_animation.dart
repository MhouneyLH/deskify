import 'package:deskify/model/desk.dart';
import 'package:flutter/material.dart';

class DeskAnimation extends StatefulWidget {
  final double? width;
  final double? height;
  final double deskHeight;

  const DeskAnimation({
    this.width = 200.0,
    this.height = Desk.maximumHeight,
    required this.deskHeight,
    super.key,
  });

  @override
  State<DeskAnimation> createState() => _DeskAnimationState();
}

class _DeskAnimationState extends State<DeskAnimation> {
  Widget _buildDesk() {
    const double height = 10.0;

    return Positioned(
      left: 0,
      right: 0,
      bottom:
          (widget.deskHeight / Desk.maximumHeight) * widget.height! - height,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildFoot(bool isLeftFoot) {
    final double footMarginToBoundaries = widget.width! / 8;

    return Positioned(
      left: isLeftFoot ? footMarginToBoundaries : null,
      right: isLeftFoot ? null : footMarginToBoundaries,
      bottom: 0,
      child: Container(
        width: 10,
        height: (widget.deskHeight / Desk.maximumHeight) * widget.height!,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          _buildDesk(),
          _buildFoot(true),
          _buildFoot(false),
        ],
      ),
    );
  }
}
