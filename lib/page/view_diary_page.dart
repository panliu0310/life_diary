// route reference: https://docs.flutter.dev/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:life_diary/src/schema/diary.dart';
import 'package:life_diary/utils/database_service.dart';

class ViewDiaryPage extends StatefulWidget
{
  final String currentDiaryId;
  const ViewDiaryPage({super.key, required this.currentDiaryId});

  @override
  State<ViewDiaryPage> createState() => _ViewDiaryPageState();
}

class _ViewDiaryPageState extends State<ViewDiaryPage>{

  DatabaseService service = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Diary page'),
        backgroundColor: Colors.lightBlue,
      ),
      body:
        Column(
          children: [
            Text("test")
          ],
        )
    );
  }
}