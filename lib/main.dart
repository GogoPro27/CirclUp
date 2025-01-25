import 'package:flutter/material.dart';
import 'package:circl_up_app/navigation/route_generator.dart';
import 'package:circl_up_app/widgets/instagram_style_navigation.dart';
import 'data/mock_data.dart';
import 'utils/constants.dart';

void main() {
  initializeUserFriends();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circl Up',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white, // Text/Icon color
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kSecondaryColor,
        ),
      ),
      home: InstagramStyleNavigation(), // Use InstagramStyleNavigation here
      onGenerateRoute: RouteGenerator.generateRoute, // Add this to handle named routes
    );
  }
}
