import 'package:fit_track/screens/activity_screen.dart';
import 'package:fit_track/screens/goals_screen.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _pages = [HomePage(), ActivityScreen(), GoalsScreen()];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue.shade900,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, color: Colors.grey),
            label: 'Home',
            activeIcon: Icon(Icons.home_filled, color: Colors.blue.shade900),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run, color: Colors.grey),
            activeIcon: Icon(Icons.directions_run, color: Colors.blue.shade900),
            label: 'Activity',
            // activeIcon:
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'Goals',
            activeIcon: Icon(
              Icons.check_box_outlined,
              color: Colors.blue.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
