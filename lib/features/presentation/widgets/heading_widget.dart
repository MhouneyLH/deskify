import 'package:flutter/material.dart';

/// A widget that displays a heading with the correct font and size.
///
/// The heading is displayed as a [Text] widget.
class Heading extends StatelessWidget {
  final String title;

  const Heading({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.displayLarge,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
