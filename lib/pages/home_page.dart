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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const HomePageTab(),
      const AddDeviceTab(),
      const SettingsTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(MainApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => setState(() {
                selectedIndex = index;
              }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ]),
      body: SingleChildScrollView(
        child: tabs[selectedIndex],
      ),
    );
  }
}
