import 'package:flutter/material.dart';

// custom heading between different parts of a page / tab
// able to have any widgets next to the title
class Heading extends StatefulWidget {
  final String title;
  final List<Widget>? nextToHeadingWidgets;
  final void Function()? onTapped;

  const Heading({
    required this.title,
    this.nextToHeadingWidgets,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(),
          _buildNextToHeadingWidgets(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Text(
        widget.title,
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildNextToHeadingWidgets() {
    return widget.nextToHeadingWidgets == null
        ? const SizedBox()
        : Row(children: [...widget.nextToHeadingWidgets!]);
  }
}
