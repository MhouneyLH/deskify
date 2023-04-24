import 'package:flutter/material.dart';

class InteractionWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressedWholeWidget(),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(width, height)),
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
              onPressedSettingsIcon != null
                  ? _buildSettingsButton(context)
                  : const SizedBox(),
            ],
          ),
          SizedBox(height: extraInformationWidget == null ? 0.0 : 5.0),
          _buildExtraInformationWidget(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      icon.icon,
    );
  }

  Widget _buildTitle(context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSettingsButton(context) {
    return Ink(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: InkWell(
        onTap: () => onPressedSettingsIcon!(),
        borderRadius: BorderRadius.circular(100.0),
        child: const Icon(Icons.settings),
      ),
    );
  }

  Widget _buildExtraInformationWidget() {
    return extraInformationWidget == null
        ? const SizedBox()
        : extraInformationWidget!;
  }
}
