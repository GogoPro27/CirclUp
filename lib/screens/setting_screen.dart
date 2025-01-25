import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 1; // Default to settings tab

  void _onItemTapped(int index) {
    if (index == 1) return; // Stay on the SettingsScreen
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/'); // Redirect to HomeScreen
        break;
      case 2:
        Navigator.pushNamed(context, '/notifications'); // Redirect to NotificationsScreen
        break;
      case 3:
        Navigator.pushNamed(context, '/profile'); // Redirect to ProfileScreen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          _buildSettingsOption(
            context,
            icon: Icons.notifications,
            title: 'Notification Settings',
            onTap: () {
              // Navigate to Notification Settings
            },
          ),
          _buildSettingsOption(
            context,
            icon: Icons.lock,
            title: 'Password Manager',
            onTap: () {
              // Navigate to Password Manager
            },
          ),
          _buildSettingsOption(
            context,
            icon: Icons.help_outline,
            title: 'Delete Account',
            onTap: () {
              // Navigate to Delete Account
            },
          ),
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
            icon: Icon(Icons.settings),
            label: 'Settings',
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

  Widget _buildSettingsOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
      onTap: onTap,
    );
  }
}
