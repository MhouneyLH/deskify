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
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: UniqueKey(),
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
        padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIcon(),
              const SizedBox(width: 10.0),
              _buildTitle(context),
              const Expanded(child: SizedBox()),
              widget.onPressedSettingsIcon != null
                  ? _buildSettingsButton(context)
                  : const SizedBox(),
            ],
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
    return Text(
      widget.title,
      style: Theme.of(context).textTheme.labelLarge,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSettingsButton(context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      splashRadius: 20.0,
      onPressed: widget.onPressedSettingsIcon!,
    );
  }

  Widget _buildExtraInformationWidget() {
    return widget.extraInformationWidget == null
        ? const SizedBox()
        : widget.extraInformationWidget!;
  }
}
