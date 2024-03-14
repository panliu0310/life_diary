import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:life_diary/src/schema/users.dart';
import 'package:life_diary/utils/constant.dart';
import 'package:life_diary/utils/database_service.dart';

import '../widgets/bottom_navigation_bar.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> signInHandle(User firebaseAuthInstanceUser)
  async {
    DatabaseService service = DatabaseService();
    bool bNotExist = await service.retrieveUsers(firebaseAuthInstanceUser.uid) == null;
    if (bNotExist) {
      service.createUser(
        Users(
          id: firebaseAuthInstanceUser.uid,
          username: firebaseAuthInstanceUser.displayName,
          email: firebaseAuthInstanceUser.email,
          diaryId: [])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              GoogleProvider(clientId: firebaseClientId),
            ],
          );
        }

        User? firebaseAuthInstanceUser = FirebaseAuth.instance.currentUser;

        if (firebaseAuthInstanceUser != null) {
          signInHandle(firebaseAuthInstanceUser);
        }

        return const MyBottomNavigationBar();
      },
    );
  }
}