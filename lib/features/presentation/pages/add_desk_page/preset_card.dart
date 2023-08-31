import 'package:deskify/features/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/preset.dart';
import '../../themes/theme.dart';

/// A card for showing information about a preset.
///
/// The card is used in the [AddDeskPage].
class PresetCard extends StatefulWidget {
  final Preset preset;

  const PresetCard({
    required this.preset,
    super.key,
  });

  @override
  State<PresetCard> createState() => _PresetCardState();
}

class _PresetCardState extends State<PresetCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: const Icon(Icons.height),
                title: Text(widget.preset.name),
                subtitle: Text('${widget.preset.targetHeight} cm'),
                iconColor: Theme.of(context).colorScheme.primary,
                subtitleTextStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            CustomIconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            const SizedBox(width: ThemeSettings.largeSpacing),
          ],
        ),
      ),
    );
  }
}
