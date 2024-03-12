import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_diary/src/schema/users.dart';

class UserUtil {
  static Future<void> createUserCollection(User firebaseAuthInstanceUser)
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

  static Future<Users?>? retrieveUserCollection(User firebaseAuthInstanceUser)
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
}

class DateUtil {
  static String dateToString(DateTime dateTime) => '';
  static DateTime stringToDate(String str) => DateTime.now();
}