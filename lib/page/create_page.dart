// route reference: https://docs.flutter.dev/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:life_diary/page/create_diary_page.dart';
import 'package:life_diary/src/schema/users.dart';

class CreatePage extends StatefulWidget
{
  final Users? currentUser;
  const CreatePage({super.key, required this.currentUser});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create page'),
        backgroundColor: Colors.lightBlue,
      ),
      body:
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(5),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[                 

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateDiaryPage(
                                  currentUser: widget.currentUser)),
                        );
                      },
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.lightBlue,
                        //textStyle: const TextStyle(fontSize: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ), 
                      child: Text("創造故事"),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateDiaryPage(
                                  currentUser: widget.currentUser)),
                        );
                      },
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.lightBlue,
                        //textStyle: const TextStyle(fontSize: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ), 
                      child: Text("創造世記"),
                    ),
                  ),
                ],
              ),
          ),
        ),
    );
  }
}