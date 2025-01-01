import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TransformationController _controller;
  late double _scale;

  @override
  void initState() {
    super.initState();
    _scale = 0.4; // Initial zoom level
    _controller = TransformationController();
    _controller.value = Matrix4.identity()..scale(_scale);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Constrained scrollable map
          ClipRect(
            child: InteractiveViewer(
              transformationController: _controller,
              constrained: false,
              boundaryMargin: EdgeInsets.zero,
              minScale: _scale,
              maxScale: _scale,
              scaleEnabled: false, // Disable manual zooming
              child: SizedBox(
                width: 8192, // Full map width
                height: 3993, // Full map height
                child: Image.asset(
                  'assets/skopje_map.jpg', // Your map file
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Navigation bar
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.map), // Map icon
                  label: 'Map',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), // Rewards icon
                  label: 'Rewards',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), // Notifications icon
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person), // Profile icon
                  label: 'Profile',
                ),
              ],
              onTap: (index) {
                // Navigation logic
                switch (index) {
                  case 0:
                    // Stay on the map screen
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/rewards');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/notifications');
                    break;
                  case 3:
                    Navigator.pushNamed(context, '/profile');
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}