import 'package:flutter/material.dart';

class DiaryPreview extends StatefulWidget {
  final String diaryId;
  const DiaryPreview(
      {super.key, required this.diaryId});
  @override
  State<DiaryPreview> createState() => _DiaryPreviewState();
}

class _DiaryPreviewState extends State<DiaryPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SizedBox(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue)
          ),
          child: Text(
            widget.diaryId,
            style: TextStyle(
              color: Colors.yellow
            ),
          )
        )
      )
    );
  }
}
