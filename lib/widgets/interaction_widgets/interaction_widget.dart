import 'package:flutter/material.dart';

class InteractionWidget extends StatefulWidget {
  final String title;
  final Icon icon;
  final double width;
  final double height;
  final void Function() onPressedWholeWidget;
  final void Function()? onPressedSettingsIcon;
  final Widget? extraInformationWidget;

  const InteractionWidget({
    required this.title,
    this.icon = const Icon(Icons.abc),
    this.width = 200.0,
    this.height = 50.0,
    required this.onPressedWholeWidget,
    this.onPressedSettingsIcon,
    this.extraInformationWidget,
    super.key,
  });

  @override
  State<InteractionWidget> createState() => _InteractionWidgetState();
}

class _InteractionWidgetState extends State<InteractionWidget> {
  final double _padding = 10.0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPressedWholeWidget(),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(widget.width, widget.height)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        backgroundColor:
            MaterialStatePropertyAll(Theme.of(context).primaryColor),
        padding: MaterialStateProperty.all(EdgeInsets.all(_padding)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: widget.height - 2 * _padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildIcon(),
                const SizedBox(width: 10.0),
                _buildTitle(context),
                const SizedBox(width: 10.0),
                _buildSettingsButton(),
              ],
            ),
          ),
          SizedBox(height: widget.extraInformationWidget == null ? 0.0 : 5.0),
          _buildExtraInformationWidget(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      widget.icon.icon,
    );
  }

  Widget _buildTitle(context) {
    return Expanded(
      child: Text(
        widget.title,
        style: Theme.of(context).textTheme.labelLarge,
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildSettingsButton() {
    const double size = 25.0;

    return widget.onPressedSettingsIcon == null
        ? const SizedBox()
        : SizedBox(
            width: size,
            height: size,
            child: IconButton(
              icon: const Icon(Icons.settings),
              padding: const EdgeInsets.all(0.0),
              alignment: Alignment.center,
              iconSize: size,
              splashRadius: size,
              onPressed: widget.onPressedSettingsIcon!,
            ),
          );
  }

  Widget _buildExtraInformationWidget() {
    return widget.extraInformationWidget == null
        ? const SizedBox()
        : widget.extraInformationWidget!;
  }
}
