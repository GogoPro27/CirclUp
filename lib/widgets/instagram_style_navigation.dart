import 'package:flutter/material.dart';
import 'package:circl_up_app/screens/map_screen.dart'; // 👈 Import
import 'package:circl_up_app/screens/notifications_screen.dart';
import 'package:circl_up_app/screens/profile_screen.dart';
import 'package:circl_up_app/screens/rewards_screen.dart';

class InstagramStyleNavigation extends StatefulWidget {
  const InstagramStyleNavigation({Key? key}) : super(key: key);

  @override
  _InstagramStyleNavigationState createState() =>
      _InstagramStyleNavigationState();
}

class _InstagramStyleNavigationState extends State<InstagramStyleNavigation> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          MapScreen(),  // 👈 Now first tab is the map
          RewardsScreen(),
          NotificationsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
