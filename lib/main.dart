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
  initializeUserFriends();

  runApp(const MyApp());

  // ====================== DEBUG START ======================
  // Fetch events AFTER the app starts, so it won’t freeze the UI
  Future.delayed(Duration.zero, () async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('Events').get();
      final events = snapshot.docs.map((doc) => Event.fromMap(doc.data())).toList();

      for (var e in events) {
        print('🔥 Event: ${e.description}');
        print('   Attendees: ${e.attendees}');
        print('   Place: ${e.place.name} at (${e.place.x}, ${e.place.y})');
      }
    } catch (e) {
      print('❌ Error fetching events: $e');
    }
  });
  // ====================== DEBUG END ========================
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
