import '../themes/theme.dart';
import 'package:flutter/material.dart';

/// An own [IconButton] that has less padding than the standard [IconButton].
///
/// When we just use [IconButton] then we have a base size of 48.0 x 48.0 as this is standard for Material Design.
/// For more information see: https://stackoverflow.com/questions/50381157/how-do-i-remove-flutter-iconbutton-big-padding
///
/// We want to have a smaller size for our [IconButton]s, so we use a [InkWell] and a [Icon] (+ an **optional** padding) instead.
class CustomIconButton extends StatefulWidget {
  final Icon icon;
  final Function() onPressed;
  final EdgeInsetsGeometry padding;

  const CustomIconButton({
    required this.icon,
    required this.onPressed,
    this.padding = const EdgeInsets.all(ThemeSettings.smallPadding),
    super.key,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  late final Color iconColor = Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onPressed,
        splashColor: iconColor.withOpacity(0.2),
        highlightColor: iconColor.withOpacity(0.4),
        // hopefully we never have an icon at this point that is bigger than 200x200...
        borderRadius: BorderRadius.circular(200.0),
        child: Padding(
          padding: widget.padding,
          child: widget.icon,
        ),
      ),
    );
  }
}
