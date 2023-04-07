import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String? title;
  final double? padding;

  const Heading({
    @required this.title,
    this.padding = 0.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$title",
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
