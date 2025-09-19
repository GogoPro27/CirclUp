import 'package:circl_up_app/screens/camera_page.dart';
import 'package:circl_up_app/screens/group_chat_page.dart';
import 'package:circl_up_app/screens/match_page.dart';
import 'package:flutter/material.dart';
import 'package:circl_up_app/screens/home_screen.dart';
import 'package:circl_up_app/screens/rewards_screen.dart';
import 'package:circl_up_app/screens/notifications_screen.dart';
import 'package:circl_up_app/screens/profile_screen.dart';

import '../data/data.dart';
import '../screens/favorites_screen.dart';
import '../screens/friends_screen.dart';
import '../screens/edit_screen.dart';
import '../screens/privaty_policy_screen.dart';
import '../screens/setting_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/rewards':
        return MaterialPageRoute(builder: (_) => const RewardsScreen());
      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/friends':
        return MaterialPageRoute(
          builder: (_) => FriendsScreen(user: mockUsers[0]),
        );
      case '/favorites':
        return MaterialPageRoute(
          builder: (_) => FavoritesScreen(user: mockUsers[0]),
        );
      case '/edit':
        return MaterialPageRoute(builder: (_) => const EditScreen());
      case '/privacy-policy':
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}