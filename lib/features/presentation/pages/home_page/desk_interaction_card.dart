import 'package:flutter/material.dart';

import '../../themes/theme.dart';
import '../../widgets/widgets.dart';

/// A card like Button with which the user can interact.
///
/// There are 2 widgets that can be displayed optionally:
/// - an icon at the end of the card (e. g. used for a settings [IconButton])
/// - a child widget (e. g. used for a [LinearProgressIndicator]])
class DeskInteractionCard extends StatefulWidget {
  final String title;
  final Icon iconAtStart;
  final Function() onPressedCard;
  final Icon? iconAtEnd;
  final Function()? onPressedIconAtEnd;
  final Widget? child;

  const DeskInteractionCard({
    required this.title,
    required this.iconAtStart,
    required this.onPressedCard,
    this.iconAtEnd,
    this.onPressedIconAtEnd,
    this.child,
    super.key,
  });

  static const _cardPadding = EdgeInsets.all(9.0);

  @override
  State<DeskInteractionCard> createState() => _DeskInteractionCardState();
}

class _DeskInteractionCardState extends State<DeskInteractionCard> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressedCard,
      style: _buildButtonStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(widget.iconAtStart.icon),
              const SizedBox(width: ThemeSettings.mediumSpacing),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Visibility(
                visible: widget.iconAtEnd != null,
                child: const Spacer(),
              ),
              widget.iconAtEnd == null
                  ? Container()
                  : CustomIconButton(
                      onPressed: widget.onPressedIconAtEnd!,
                      icon: widget.iconAtEnd!,
                    )
            ],
          ),
          Visibility(
            visible: widget.child != null,
            child: const SizedBox(height: ThemeSettings.mediumSpacing),
          ),
          widget.child ?? Container(),
        ],
      ),
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      padding: MaterialStateProperty.all(DeskInteractionCard._cardPadding),
    );
  }
}
