import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? id;
  final String? username;
  final String? email;
  final List<String>? diaryCategory;
  final List<String>? diaryId;

  Users({
    required this.id,
    required this.username,
    required this.email,
    required this.diaryCategory,
    required this.diaryId,
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
      diaryCategory: 
        data?['diaryCategory'] is Iterable ? List.from(data?['diaryCategory']) : null,
      diaryId:
        data?['diaryId'] is Iterable ? List.from(data?['diaryId']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (username != null) "username": username,
      if (email != null) "email": email,
      if (diaryCategory != null) "diaryCategory" : diaryCategory,
      if (diaryId != null) "diaryId": diaryId,
    };
  }
}