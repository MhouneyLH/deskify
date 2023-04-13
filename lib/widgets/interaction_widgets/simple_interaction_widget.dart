import 'package:flutter/material.dart';

class SimpleInteractionWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final double width;
  final double height;
  final void Function() onPressed;

  const SimpleInteractionWidget({
    required this.title,
    this.icon = const Icon(Icons.abc),
    this.width = 200.0,
    this.height = 50.0,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(width, height)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        // TODO: backgroundColor: MaterialStateProperty.all(Colors.blue),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIcon(),
          const SizedBox(width: 10.0),
          _buildTitle(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      icon.icon,
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20.0,
      ),
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
