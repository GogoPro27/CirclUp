import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:circl_up_app/screens/sign_in_screen.dart';

class AuthGate extends StatelessWidget {
  final Widget signedInChild; // your real app

  const AuthGate({Key? key, required this.signedInChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return signedInChild;
        }
        return const SignInScreen();
      },
    );
  }
}