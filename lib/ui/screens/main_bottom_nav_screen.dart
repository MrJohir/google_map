import 'package:flutter/material.dart';
import 'package:google_map/ui/screens/contribute_screen.dart';
import 'package:google_map/ui/screens/home_screen.dart';
import 'package:google_map/ui/screens/map_explore_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MapExploreScreen(),
    HomeScreen(),
    ContributeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white38,
        indicatorColor: Colors.teal,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.location_on),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            label: 'You',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Contribute',
          ),
        ],
      ),
    );
  }
}
