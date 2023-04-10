import 'package:deskify/main.dart';
import 'package:deskify/widgets/tabs/add_device_tab.dart';
import 'package:deskify/widgets/tabs/home_page_tab.dart';
import 'package:deskify/widgets/tabs/settings_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      const HomePageTab(),
      const AddDeviceTab(),
      const SettingsTab(),
    ];

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

  bool _isHomePage() => selectedTabIndex == 0;
}
