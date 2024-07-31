import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:life_diary/src/schema/users.dart';
import 'package:life_diary/utils/constant.dart';
import 'package:life_diary/utils/database_service.dart';

import '../widgets/bottom_navigation_bar.dart';

import '../widgets/globals.dart' as globals;

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<Users> signInHandle(User firebaseAuthInstanceUser)
  async {
    DatabaseService service = DatabaseService();
    Users? retrievedUser = await service.retrieveUsers(firebaseAuthInstanceUser.uid);
    //bool bNotExist = await service.retrieveUsers(firebaseAuthInstanceUser.uid) == null;
    if (retrievedUser == null) {
      Users newUser = Users(
        id: firebaseAuthInstanceUser.uid,
          username: firebaseAuthInstanceUser.displayName,
          email: firebaseAuthInstanceUser.email,
          diaryCategory: ['學', '職', '情'],
          diaryId: []
      );
      service.createUser(newUser);
      return newUser;
    }
    
    return retrievedUser;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot1) {
        if (!snapshot1.hasData) {
          // if not logged in
          return SignInScreen(
            providers: [
              GoogleProvider(clientId: firebaseClientId),
            ],
          );
        }

        // if logged in
        return FutureBuilder<Users?>(
// solution for 2 stream: https://stackoverflow.com/questions/51880330/flutter-stream-two-streams-into-a-single-screen
            future: signInHandle(FirebaseAuth.instance.currentUser!),
            builder: (context, snapshot2) {
              if (!snapshot2.hasData)
              {
                // user data not retrieved yet, waiting...
                return const Center(child: CircularProgressIndicator());
              }
              // TODO: splash screen
              globals.currentUser = snapshot2.data;
              return MyBottomNavigationBar();
            },
          );
      },
    );
  }
}