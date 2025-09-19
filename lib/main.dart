import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:circl_up_app/navigation/route_generator.dart';
import 'package:circl_up_app/widgets/instagram_style_navigation.dart';
import 'package:circl_up_app/screens/auth_gate.dart';

import 'data/data.dart';
import 'utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await loadMockData();

  const forceSignOutOnLaunch = true; // TEMP for testing
  if (forceSignOutOnLaunch) {
    await FirebaseAuth.instance.signOut();
  }

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
      home: const AuthGate(
        signedInChild: InstagramStyleNavigation(), // your existing entry
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}