import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? id;
  final String? username;
  final String? email;
  final List<String>? diaryId;

  Users({
    this.id,
    this.username,
    this.email,
    this.diaryId,
  });

  factory Users.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Users(
      id: data?['id'],
      username: data?['username'],
      email: data?['email'],
      diaryId:
          data?['diaryId'] is Iterable ? List.from(data?['diaryId']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (username != null) "username": username,
      if (email != null) "email": email,
      if (diaryId != null) "diaryId": diaryId,
    };
  }
}