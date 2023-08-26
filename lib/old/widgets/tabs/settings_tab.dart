import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/desk_provider.dart';
import '../../provider/profile_provider.dart';
import '../../provider/theme_provider.dart';

// tab for displaying the settings
// currently only:
// - profile summary (profile image, name, email)
// - theme switch
class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late DeskProvider deskProvider;
  late ProfileProvider profileProvider;
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildProfileSummary(),
        const SizedBox(height: 10.0),
        _buildThemeSwitch(),
      ],
    );
  }

  Widget _buildProfileSummary() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileImage(),
            const SizedBox(width: 10.0),
            _buildProfileInformation(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    const double size = 75.0;

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Icon(
          profileProvider.image.icon,
          size: size * 0.75,
        ),
      ),
    );
  }

  Widget _buildProfileInformation() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInformationText(profileProvider.name),
              const SizedBox(height: 10.0),
              _buildInformationText(profileProvider.email),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildInformationText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15.0,
      ),
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildThemeSwitch() {
    return Row(
      children: [
        const Text('Darktheme'),
        const SizedBox(width: 10.0),
        Switch(
          value: themeProvider.themeSettings.isDarkTheme,
          onChanged: (bool value) => themeProvider.updateTheme(value),
        ),
      ],
    );
  }
}
