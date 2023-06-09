import 'package:flutter/material.dart';

// a widget (button-like) that can be used to interact with the app
// can have an extra information widget, like e. g. the progress bar in the
// analyitcalIntercationWidgets
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
    required this.icon,
    required this.onPressedWholeWidget,
    this.width = 200.0,
    this.height = 50.0,
    this.onPressedSettingsIcon,
    this.extraInformationWidget,
    super.key,
  });

  @override
  State<InteractionWidget> createState() => _InteractionWidgetState();
}

class _InteractionWidgetState extends State<InteractionWidget> {
  final double _padding = 10.0;
  final double _iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPressedWholeWidget(),
      style: _buildButtonStyle(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _getHeightOfWidgetExceptExtraInformationWidget(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildIcon(),
                const SizedBox(width: 10.0),
                _buildTitle(context),
                const SizedBox(width: 10.0),
                _buildSettingsButton(),
                SizedBox(width: _padding / 4),
              ],
            ),
          ),
          SizedBox(height: widget.extraInformationWidget == null ? 0.0 : 5.0),
          _buildExtraInformationWidget(),
        ],
      ),
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
      fixedSize: MaterialStateProperty.all(
        Size(
          widget.width,
          widget.height,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      padding: MaterialStateProperty.all(EdgeInsets.all(_padding)),
    );
  }

  Widget _buildIcon() {
    return Icon(
      widget.icon.icon,
      size: _iconSize,
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
    return widget.onPressedSettingsIcon == null
        ? const SizedBox()
        : SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: IconButton(
              icon: const Icon(Icons.settings),
              padding: const EdgeInsets.all(0.0),
              alignment: Alignment.center,
              iconSize: _iconSize,
              splashRadius: _iconSize,
              onPressed: widget.onPressedSettingsIcon!,
            ),
          );
  }

  Widget _buildExtraInformationWidget() {
    return widget.extraInformationWidget == null
        ? const SizedBox()
        : widget.extraInformationWidget!;
  }

  double _getHeightOfWidgetExceptExtraInformationWidget() =>
      widget.height - 2 * _padding;
}
