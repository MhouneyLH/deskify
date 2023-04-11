import 'dart:async';
import 'package:deskify/main.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/widgets/tabs/add_device_tab.dart';
import 'package:deskify/widgets/tabs/home_page_tab.dart';
import 'package:deskify/widgets/tabs/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double standingBreakpointHeight = 90.0;

  int selectedTabIndex = 0;
  DeskProvider? deskProvider;
  ProfileProvider? profileProvider;
  late Timer analyticSecondTimer;

  @override
  void initState() {
    super.initState();
    analyticSecondTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      const HomePageTab(),
      const AddDeviceTab(),
      const SettingsTab(),
    ];

    deskProvider = Provider.of<DeskProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);

    final List<BottomNavigationBarItem> navigationBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: "Add",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Settings",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(MainApp.title),
      ),
      floatingActionButton: _isHomePage()
          ? FloatingActionButton(
              onPressed: () => _updateSelectedTabIndex(2),
              child: const Icon(Icons.settings),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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

  void _updateSelectedTabIndex(int index) {
    setState(
      () => selectedTabIndex = index,
    );
  }

  void _updateAnalytics() {
    deskProvider!.height > standingBreakpointHeight
        ? profileProvider!.addStandingTimeActual(1.0)
        : profileProvider!.addSittingTimeActual(1.0);
  }

  bool _isHomePage() => selectedTabIndex == 0;
}
