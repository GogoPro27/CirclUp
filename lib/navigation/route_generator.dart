import 'package:circl_up_app/screens/camera_page.dart';
import 'package:circl_up_app/screens/group_chat_page.dart';
import 'package:circl_up_app/screens/match_page.dart';
import 'package:flutter/material.dart';
import 'package:circl_up_app/screens/home_screen.dart';
import 'package:circl_up_app/screens/rewards_screen.dart';
import 'package:circl_up_app/screens/notifications_screen.dart';
import 'package:circl_up_app/screens/profile_screen.dart';

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
      case '/match':
        return MaterialPageRoute(builder: (_) => const MatchPage());
      case '/group-chat':
        return MaterialPageRoute(builder: (_) => const GroupChatPage());
      case '/camera':
        return MaterialPageRoute(
          builder: (_) => CameraPage(
            onPhotoCaptured: () {
              // Navigator.of(context).pop();
            },
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}