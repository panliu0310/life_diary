// route reference: https://docs.flutter.dev/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:life_diary/src/schema/users.dart';
import 'package:life_diary/utils/database_service.dart';

class CreateDiaryPage extends StatefulWidget
{
  final Users user;
  const CreateDiaryPage({super.key, required this.user});

  @override
  State<CreateDiaryPage> createState() => _CreateDiaryPageState();
}

class _CreateDiaryPageState extends State<CreateDiaryPage>{

  DatabaseService service = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Diary page'),
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
// UI reference on text field: https://stackoverflow.com/questions/50400529/how-to-change-textfields-height-and-width
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        isDense: true, // set isDense to true to solve inner margin problem
                        border: OutlineInputBorder(),
                        labelText: 'Date',
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        labelText: 'Category',
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      //validator: validateName,
// reference of multi-line: https://stackoverflow.com/questions/45900387/multi-line-textfield-in-flutter
                      minLines: 10,
                      maxLines: null,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        labelText: 'Content',
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
    );
  }
}