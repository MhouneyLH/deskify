import 'package:flutter/material.dart';

import '../themes/theme.dart';
import 'widgets.dart';

/// A card like Button with which the user can interact.
///
/// If you don't want the ripple effect, you just don't have to set the [onPressedCard] property.
///
/// There are 2 widgets that can be displayed optionally:
/// - an icon at the end of the card (e. g. used for a settings [IconButton])
/// - a child widget (e. g. a [LinearProgressIndicator]])
///
/// This widget internally uses the [Card] widget.
class InteractionCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Icon iconAtStart;
  final Function()? onPressedCard;
  final Icon? iconAtEnd;
  final Function()? onPressedIconAtEnd;
  final Widget? child;

  const InteractionCard({
    required this.title,
    required this.iconAtStart,
    this.subtitle,
    this.onPressedCard,
    this.iconAtEnd,
    this.onPressedIconAtEnd,
    this.child,
    super.key,
  });

  static const double _splashColorOpacity = 0.2;
  static const double _highlightColorOpacity = 0.4;

  @override
  State<InteractionCard> createState() => _InteractionCardState();
}

class _InteractionCardState extends State<InteractionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      key: const Key('interaction-card'),
      // needed for a clean ripple effect
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: widget.onPressedCard,
        splashColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(InteractionCard._splashColorOpacity),
        highlightColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(InteractionCard._highlightColorOpacity),
        child: Padding(
          padding: const EdgeInsets.all(ThemeSettings.mediumPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: widget.iconAtStart,
                      title: Text(widget.title),
                      subtitle: widget.subtitle == null
                          ? null
                          : Text(widget.subtitle!),
                      iconColor: Theme.of(context).colorScheme.primary,
                      subtitleTextStyle:
                          Theme.of(context).textTheme.labelMedium,
                      contentPadding: EdgeInsets.zero,
                    ),
                    widget.child ?? Container(),
                  ],
                ),
              ),
              Visibility(
                visible: widget.iconAtEnd != null,
                child: const SizedBox(width: ThemeSettings.mediumSpacing),
              ),
              widget.iconAtEnd == null
                  ? Container()
                  : CustomIconButton(
                      icon: widget.iconAtEnd!,
                      onPressed: widget.onPressedIconAtEnd!,
                    ),
              Visibility(
                visible: widget.iconAtEnd != null,
                child: const SizedBox(width: ThemeSettings.mediumSpacing),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
