import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import '../src/widgets/bottom_navigation_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              //EmailAuthProvider(), // new
              GoogleProvider(clientId: "893498280126-rrvfa87s7ojf1vhjkut5e9jn9qkqbrgo.apps.googleusercontent.com"),
            ],
          );
        }

        return const MyBottomNavigationBar();
      },
    );
  }
}