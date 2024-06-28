import 'package:flutter/material.dart';
import 'package:life_diary/src/schema/diary.dart';
import 'package:life_diary/utils/database_service.dart';

class DiaryPreview extends StatefulWidget {
  final String diaryId;
  const DiaryPreview(
      {super.key, required this.diaryId});
  @override
  State<DiaryPreview> createState() => _DiaryPreviewState();
}

class _DiaryPreviewState extends State<DiaryPreview> {
  DatabaseService service = DatabaseService();
  Future<Diary?>? currentDiary;
  Diary? retrievedDiary;
  
  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    currentDiary = service.retrieveDiary(widget.diaryId);
    retrievedDiary = await service.retrieveDiary(widget.diaryId);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SizedBox(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.zero,
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
          child: FutureBuilder(
            future: currentDiary,
            builder:
              (BuildContext context, AsyncSnapshot<Diary?> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[ 
                      Text(
                        retrievedDiary!.title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                    ]
                  );
                }
                
                return Text("");
              }
          )
        )
      )
    );
  }
}
