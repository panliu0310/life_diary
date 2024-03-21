// retrieve data from firebase and store in initial state
// first refernce, from FlutterFire doc: https://firebase.google.com/docs/firestore/query-data/get-data
// reference: https://petercoding.com/firebase/2022/02/16/how-to-model-your-firebase-data-class-in-flutter/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_diary/src/schema/diary.dart';
import 'package:life_diary/src/schema/users.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(Users usersData)
  async {
    final docRef = _db
      .collection("users")
      .withConverter(
        fromFirestore: Users.fromFirestore,
        toFirestore: (Users newUser, options) => newUser.toFirestore(),
      )
      .doc(usersData.id);
    await docRef.set(usersData);
  }

  Future<Users?> retrieveUsers(String uid) async {
    final ref = _db.collection("users").doc(uid).withConverter(
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

  Future<void> createDiary(Diary diaryData)
  async {
    final docRef = _db
      .collection("diaries")
      .withConverter(
        fromFirestore: Diary.fromFirestore,
        toFirestore: (Diary newDiary, options) => newDiary.toFirestore(),
      )
      .doc(diaryData.id);
    await docRef.set(diaryData);
  }
}