import 'package:deskify/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  ProfileProvider? profileProvider;

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            // TODO: color: Colors.blue[700],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _buildProfileSummary(),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildProfileImage(),
        const SizedBox(width: 10.0),
        _buildProfileInformation(),
      ],
    );
  }

  Widget _buildProfileImage() {
    const double size = 75.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(size),
      ),
      child: Icon(
        profileProvider!.image.icon,
        size: size * 0.75,
        color: Theme.of(context).accentColor,
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
              _buildInformationText(profileProvider!.name!),
              const SizedBox(height: 10.0),
              _buildInformationText(profileProvider!.email!),
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
}
