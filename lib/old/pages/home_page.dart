import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../model/desk.dart';
import '../provider/desk_provider.dart';
import '../provider/profile_provider.dart';
import '../utils.dart';
import '../widgets/tabs/add_desk_tab.dart';
import '../widgets/tabs/home_page_tab.dart';
import '../widgets/tabs/settings_tab.dart';

// superordinate widget for controlling the tabs, bottom navigation bar, etc.
// also taking care of the global timer for analytics (should tick in any tab)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DeskProvider deskProvider;
  late ProfileProvider profileProvider;

  final List<Widget> tabs = [
    const HomePageTab(),
    const AddDeskTab(),
    const SettingsTab(),
  ];

  final List<BottomNavigationBarItem> navigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: 'Add',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  late Timer analyticalTimer;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();

    analyticalTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _updateAnalytics(),
    );
  }

  @override
  void dispose() {
    analyticalTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text(MainApp.title)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTabIndex,
        onTap: (index) => _updateSelectedTabIndex(index),
        items: navigationBarItems,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: tabs[selectedTabIndex],
      ),
    );
  }

  void _updateSelectedTabIndex(int index) =>
      setState(() => selectedTabIndex = index);

  void _updateAnalytics() {
    deskProvider.currentDesk!.height > Desk.standingBreakpointHeight
        ? profileProvider.incrementStandingAnalytic(
            Utils.getCurrentWeekdayAsInt(), 1)
        : profileProvider.incrementSittingAnalytic(
            Utils.getCurrentWeekdayAsInt(), 1);
  }
}
