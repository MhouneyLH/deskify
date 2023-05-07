import 'dart:developer';

import 'package:deskify/api/firebase_api.dart';
import 'package:deskify/model/theme_settings.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late DeskProvider deskProvider;
  late ProfileProvider profileProvider;
  late ThemeProvider themeProvider;
  late bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);

    return StreamBuilder(
        stream: FirebaseApi.readTheme(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log('ERROR: ${snapshot.error}');
            return Text('Something went wrong! ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            themeProvider.addTheme(themeProvider.currentThemeSettings);
            return const Center(child: CircularProgressIndicator());
          }

          final ThemeSettings snapshotThemeSettings = snapshot.data!;
          themeProvider.setCurrentThemeSettings(snapshotThemeSettings);

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileSummary(),
              const SizedBox(height: 10.0),
              _buildThemeSwitch(),
            ],
          );
        });
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
          value: isDarkTheme,
          onChanged: (bool value) => setState(
            () {
              themeProvider.updateTheme(
                  themeProvider.currentThemeSettings, value);
            },
          ),
        ),
      ],
    );
  }
}
