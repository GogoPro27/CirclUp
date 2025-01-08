import 'package:circl_up_app/widgets/instagram_style_navigation.dart';
import 'package:flutter/material.dart';
import 'data/mock_data.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';
import 'navigation/route_generator.dart'; // Import the route generator

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
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute, // Add this
    );
  }
}