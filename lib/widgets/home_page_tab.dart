import 'package:deskify/model/desk.dart';
import 'package:deskify/pages/move_widget_page.dart';
import 'package:deskify/widgets/simple_interaction_widget.dart';
import 'package:flutter/material.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  static final Desk _currentDesk = Desk();

  void _updateCurrentDeskHeight(double value) {
    setState(() {
      _currentDesk.height = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("HomePageTab"),
          Text("${_currentDesk.name}"),
          Text("Height: ${_currentDesk.height} cm"),
          const SimpleInteractionWidget(
            title: "Stand-Info",
            icon: Icon(Icons.info),
          ),
          const SimpleInteractionWidget(
            title: "Sit-Info",
            icon: Icon(Icons.info),
          ),
          const SimpleInteractionWidget(
            title: "Move",
            icon: Icon(Icons.move_up),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MoveWidgetPage(
                    desk: _currentDesk,
                    onValueChanged: _updateCurrentDeskHeight),
              ),
            ),
            child: const Text("Move"),
          ),
          const SimpleInteractionWidget(
            title: "Preset1",
            icon: Icon(Icons.input),
          ),
          const SimpleInteractionWidget(
            title: "Preset2",
            icon: Icon(Icons.input),
          ),
          const SimpleInteractionWidget(
            title: "Preset3",
            icon: Icon(Icons.input),
          ),
        ],
      ),
    );
  }
}
