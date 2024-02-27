import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  final String? id;
  final String? userId;
  final DateTime? time;
  final String? title;
  final String? content;

  Diary({
    this.id,
    this.userId,
    this.time,
    this.title,
    this.content,
  });

  factory Diary.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Diary(
      id: data?['id'],
      userId: data?['userId'],
      time: data?['time'],
      title: data?['title'],
      content: data?['content'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (userId != null) "userId": userId,
      if (time != null) "time": time,
      if (title != null) "title": title,
      if (content != null) "content": content,
    };
  }
}