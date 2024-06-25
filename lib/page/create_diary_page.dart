// route reference: https://docs.flutter.dev/cookbook/navigation/navigation-basics
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_diary/src/schema/diary.dart';
import 'package:life_diary/src/schema/users.dart';
import 'package:life_diary/src/widgets/bottom_navigation_bar.dart';
import 'package:life_diary/utils/database_service.dart';

class CreateDiaryPage extends StatefulWidget
{
  final Users? currentUser;
  const CreateDiaryPage({super.key, required this.currentUser});

  @override
  State<CreateDiaryPage> createState() => _CreateDiaryPageState();
}

class _CreateDiaryPageState extends State<CreateDiaryPage>{

  GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');
  DatabaseService service = DatabaseService();
  DateTime dateTime = DateTime.now();

  String currentTitle = "";

  List<String> categoryList = [];
  String? currentCategory = "";

  String currentContent = "";

  @override
  Widget build(BuildContext context) {

    if (widget.currentUser!.diaryCategory != null)
    {
      categoryList = List.from(widget.currentUser!.diaryCategory as Iterable);
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
                      onChanged: (text) {
                        currentTitle = text;
                      },
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
                      onChanged: (text) {
                        currentContent = text;
                      },
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

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextButton(
                      onPressed: () async {
                        bool? bCreate = await showDialog<bool>(
                          context: context,
                          builder: (contextDialog) {
// AlertDialog reference: https://book.flutterchina.club/chapter7/dailog.html#_7-7-1-%E4%BD%BF%E7%94%A8%E5%AF%B9%E8%AF%9D%E6%A1%86
                            return AlertDialog(
                              title: Text("提示"),
                              content: Text("您確定要創建世記嗎?"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("取消"),
                                  onPressed: () {
                                    Navigator.of(contextDialog).pop(); // 关闭对话框
                                  },
                                ),
                                TextButton(
                                  child: Text("創建"),
                                  onPressed: () {
                                    Navigator.of(contextDialog).pop(true); //关闭对话框并返回true
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          }
                        );

                        if (bCreate == true)
                        {
                          String diaryId = "${DateFormat('yyyyMMddHHmmss').format(dateTime)}-$currentTitle";
                          service.createDiary(
                            Diary(
                              id: diaryId, 
                              userId: widget.currentUser!.id, 
                              time: dateTime, 
                              category: currentCategory, 
                              title: currentTitle, 
                              content: currentContent)
                          );
                          service.updateUsersAddDiaryId(widget.currentUser!.id!, diaryId);
                        }
                      },
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.lightBlue,
                        //textStyle: const TextStyle(fontSize: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ), 
                      child: Text("提交!"),
                    ),
                  ),
                ],
              ),
          ),
        ),
    );
  }
}