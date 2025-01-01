import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';
import 'navigation/route_generator.dart'; // Import the route generator

void main() {
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
      initialRoute: '/', // Define the initial route
      onGenerateRoute: RouteGenerator.generateRoute, // Use the route generator
    );
  }
}