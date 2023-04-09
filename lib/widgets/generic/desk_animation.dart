import 'package:deskify/model/desk.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeskAnimation extends StatefulWidget {
  final double? width;
  final double? height;

  const DeskAnimation({
    this.width = 200.0,
    this.height = Desk.maximumHeight,
    super.key,
  });

  @override
  State<DeskAnimation> createState() => _DeskAnimationState();
}

class _DeskAnimationState extends State<DeskAnimation> {
  DeskProvider? deskProvider;

  Widget _buildDesk() {
    const double height = 10.0;

    return Positioned(
      left: 0,
      right: 0,
      bottom:
          (deskProvider!.height / Desk.maximumHeight) * widget.height! - height,
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
        height: (deskProvider!.height / Desk.maximumHeight) * widget.height!,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);

    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        child: Stack(
          children: [
            _buildDesk(),
            _buildFoot(true),
            _buildFoot(false),
          ],
        ),
      ),
    );
  }
}
