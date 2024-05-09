// route reference: https://docs.flutter.dev/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime dateTime = DateTime.now();

  List<String> categoryList = [];
  String? currentCategory = "";

  @override
  Widget build(BuildContext context) {

    if (widget.user.diaryCategory != null)
    {
      categoryList = List.from(widget.user.diaryCategory as Iterable);
    }

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
                    child: Row(
                      children: [
                        IconButton(
// DateTime reference: https://api.flutter.dev/flutter/material/showDatePicker.html
                          onPressed: () async{
                            final result = await showDatePicker(
                              context: context,
                              initialDate: dateTime,
                              firstDate: DateTime(1950, 01),
                              lastDate: DateTime.now()
                            );
                            setState(() {
                              if (result != null) {
                                dateTime = result;
                              }
                            });
                          },
                          icon: Icon(Icons.calendar_today),
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.lightBlue,
                            //textStyle: const TextStyle(fontSize: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(dateTime),
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      ],
                    )
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
// DropdownMenu reference: https://api.flutter.dev/flutter/material/DropdownMenu-class.html
                    child: DropdownMenu<String>(
                      initialSelection: categoryList.first,
                      label: const Text('Category'),
                      
                      //menuMaxHeight: 10,
                      onSelected: (String? category) {
                        setState(() {
                          currentCategory = category;
                        });
                      },
                      dropdownMenuEntries: categoryList
                          .map<DropdownMenuEntry<String>>(
                              (String item) {
                        return DropdownMenuEntry<String>(
                          value: item,
                          label: item,
                          //enabled: color.label != 'Grey',
                          style: MenuItemButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                        );
                      }).toList(),
// reference for smaller DropDownMenu: https://stackoverflow.com/questions/77173999/make-flutter-dropdownmenu-smaller
                      inputDecorationTheme: InputDecorationTheme(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        constraints: BoxConstraints.tight(
                          const Size.fromHeight(40)
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    )
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