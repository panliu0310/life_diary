import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  final String? id;
  final String? userId;
  final DateTime? time;
  final String? category;
  final String? title;
  final String? content;

  Diary({
    required this.id,
    required this.userId,
    required this.time,
    required this.category,
    required this.title,
    required this.content,
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
      category: data?['category'],
      title: data?['title'],
      content: data?['content'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (userId != null) "userId": userId,
      if (time != null) "time": time,
      if (category != null) "category": category,
      if (title != null) "title": title,
      if (content != null) "content": content,
    };
  }
}