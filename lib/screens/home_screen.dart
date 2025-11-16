import 'package:flutter/material.dart';
import 'leaderboard_screen.dart';
import 'search_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; 

  final List<Widget> _screens = [
    const LeaderboardScreen(),
    const SearchScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey[400],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search', 
          ),
        ],
      ),
    );
  }
}
