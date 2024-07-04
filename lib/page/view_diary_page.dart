// route reference: https://docs.flutter.dev/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  Future<Diary?>? currentDiary;
  Diary? retrievedDiary;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    currentDiary = service.retrieveDiary(widget.currentDiaryId);
    retrievedDiary = await service.retrieveDiary(widget.currentDiaryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Diary page'),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Text(
                          DateFormat('yyyy-MM-dd EEEE').format(retrievedDiary!.time!),
                          textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black
                        ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Text(
                          retrievedDiary!.title!,
                          textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black
                        ),
                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: 36,
                        child: Row(
                          crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            // text button reference: https://api.flutter.dev/flutter/material/TextButton-class.html
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.lightBlue,
                                textStyle:
                                    const TextStyle(fontSize: 12.0),
                              ),
                              onPressed: () {},
                              icon: Image.asset(
                                  'assets/images/diary.png',
                                  width: 18.0),
                              label: Text(
                                  retrievedDiary!.category!),
                            ),
                          ],
                        )
                      ),

// ListView reference: https://book.flutterchina.club/chapter6/listview.html#_6-3-6-%E5%AE%9E%E4%BE%8B-%E6%97%A0%E9%99%90%E5%8A%A0%E8%BD%BD%E5%88%97%E8%A1%A8
// Column + Expanded implementation
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                            ),
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  child: 
                                    Text(
                                      retrievedDiary!.content!,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black
                                      ),
                                    ), 
                                );
                              }
                            ),
                          )
                        )
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