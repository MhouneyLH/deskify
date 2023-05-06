import 'dart:async';
import 'dart:developer';
import 'package:deskify/api/firebase_api.dart';
import 'package:deskify/main.dart';
import 'package:deskify/model/desk.dart';
import 'package:deskify/provider/desk_provider.dart';
import 'package:deskify/provider/profile_provider.dart';
import 'package:deskify/utils.dart';
import 'package:deskify/widgets/tabs/add_desk_tab.dart';
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
  late DeskProvider deskProvider;
  late ProfileProvider profileProvider;
  late Timer analyticalTimer;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAnalyticalTimer();
  }

  @override
  Widget build(BuildContext context) {
    deskProvider = Provider.of<DeskProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(MainApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTabIndex,
        onTap: (index) => _updateSelectedTabIndex(index),
        items: navigationBarItems,
      ),
      body: StreamBuilder(
        stream: FirebaseApi.readDesks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log('ERROR: ${snapshot.error}');
            return Text('Something went wrong! ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Desk> desks = snapshot.data!;
          deskProvider.setDesks(desks);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: tabs[selectedTabIndex],
          );
        },
      ),
    );
  }

  void _startAnalyticalTimer() {
    analyticalTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateAnalytics();
    });
  }

  void _updateSelectedTabIndex(int index) =>
      setState(() => selectedTabIndex = index);

  void _updateAnalytics() {
    deskProvider.currentDesk!.height! > Desk.standingBreakpointHeight
        ? profileProvider.incrementStandingAnalytic(
            Utils.getCurrentWeekdayAsInt(), 1)
        : profileProvider.incrementSittingAnalytic(
            Utils.getCurrentWeekdayAsInt(), 1);
  }
}
