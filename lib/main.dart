import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circl_up_app/navigation/route_generator.dart';
import 'package:circl_up_app/widgets/instagram_style_navigation.dart';
import 'data/mock_data.dart';
import 'utils/constants.dart';
import 'models/event.dart'; // ✅ Import your Event model

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Load data from Firestore into mock lists before starting the app
  await loadMockData();

  // Debugging: Print lengths of mock arrays
  print('mockPlaces length: ${mockPlaces.length}');
  print('mockEvents length: ${mockEvents.length}');
  print('mockUsers length: ${mockUsers.length}');
  print('mockCoupons length: ${mockCoupons.length}');
  print('mockNotifications length: ${mockNotifications.length}');

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
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kSecondaryColor,
        ),
      ),
      home: InstagramStyleNavigation(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
