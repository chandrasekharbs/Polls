import 'package:Polls/screens/HomeScreen.dart';
import 'package:Polls/screens/SettingsScreen.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({Key key}) : super(key: key);

  _BottomNavigationScreen createState() => _BottomNavigationScreen();
}

class _BottomNavigationScreen extends State<BottomNavigationScreen> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    HomeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
