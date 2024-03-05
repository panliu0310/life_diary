import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:life_diary/src/schema/users.dart';
//import 'package:life_diary/src/widgets/google_provider_button.dart';
import 'package:life_diary/utils/constant.dart';

import '../widgets/bottom_navigation_bar.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> signInHandle(User firebaseAuthInstanceUser)
  async {
    bool bNotExist = await retrieveUserCollection(firebaseAuthInstanceUser) == null;
    if (bNotExist) {
      createUserCollection(firebaseAuthInstanceUser);
    }
  }

  Future<void> createUserCollection(User firebaseAuthInstanceUser)
  async {
    var db = FirebaseFirestore.instance;

    final newUser = Users(
      id: firebaseAuthInstanceUser.uid,
      username: firebaseAuthInstanceUser.displayName,
      email: firebaseAuthInstanceUser.email,
      diaryId: [],
    );
    final docRef = db
      .collection("users")
      .withConverter(
        fromFirestore: Users.fromFirestore,
        toFirestore: (Users newUser, options) => newUser.toFirestore(),
      )
      .doc(firebaseAuthInstanceUser.displayName);
    await docRef.set(newUser);
  }

  Future<Users?>? retrieveUserCollection(User firebaseAuthInstanceUser)
  async {
    var db = FirebaseFirestore.instance;

    final ref = db.collection("users").doc(firebaseAuthInstanceUser.displayName).withConverter(
      fromFirestore: Users.fromFirestore,
      toFirestore: (Users users, _) => users.toFirestore(),
    );
    final docSnap = await ref.get();
    final user = docSnap.data(); // Convert to Users object
    if (user != null) {
      return user;
    } else {
      return null;
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