import 'package:flutter/material.dart';

import 'features/presentation/pages/add_desk_page/add_desk_page.dart';
import 'features/presentation/pages/home_page/home_page.dart';
import 'features/presentation/pages/settings_page/settings_page.dart';
import 'main.dart';

/// An app shell to display the different pages of the app.
///
/// The pages are displayed in a [BottomNavigationBar].
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const AddDeskPage(),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _navigationBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: 'Add',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MainApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationBarItems,
        currentIndex: _selectedPageIndex,
        onTap: (int index) => _updateIndex(index),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: _pages[_selectedPageIndex],
      ),
    );
  }

  void _updateIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}
