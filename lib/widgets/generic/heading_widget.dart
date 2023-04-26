import 'package:flutter/material.dart';

class Heading extends StatefulWidget {
  final String title;
  final void Function()? onTapped;

  const Heading({
    required this.title,
    this.onTapped,
    super.key,
  });

  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapped ?? () {},
      child: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
