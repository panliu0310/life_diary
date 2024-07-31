//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_diary/page/view_diary_page.dart';
import 'package:life_diary/src/schema/diary.dart';
import 'package:life_diary/src/widgets/diary_preview.dart';
import 'package:life_diary/utils/database_service.dart';
import 'package:life_diary/src/schema/users.dart';

import '../src/widgets/globals.dart' as globals;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DatabaseService service = DatabaseService();

  Future<Users?>? currentUser;
  Users? retrievedUser;
  
  //late List<Diary>? DiaryList;
  Future<Diary?>? tempDiary;
  Diary? receivedDiary;

  //String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  String categoryFilter = "";

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    await refreshUser();
    await fetchDiaryList();
  }

  Future<List<Diary>> fetchDiaryList() async{
    List<Diary> diaryList = [];

    for (int i = 0; i < globals.currentUser!.diaryId!.length; i++)
    {
      tempDiary = service.retrieveDiary(globals.currentUser!.diaryId![i]);
      receivedDiary = await service.retrieveDiary(globals.currentUser!.diaryId![i]);
      diaryList.add(receivedDiary!);
    }
    
    return diaryList;
  }

  Future<void> refreshUser() async
  {
    currentUser = service.retrieveUsers(globals.currentUser!.id!);
    retrievedUser = await service.retrieveUsers(globals.currentUser!.id!);
    globals.currentUser = retrievedUser;
  }

  Future<void> _handleRefresh() async {
    // Fetch new data and update the UI
    await refreshUser();
    await fetchDiaryList();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    //int diaryLength = currentUser.diaryId!.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.lightBlue,
      ),
// UI reference: https://github.com/dev-hub-spot101/flutter-profile-page-ui-with-masonry-grid-images/blob/master/lib/pages/profile.dart
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 25.0, top: 25.0, bottom: 25.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(globals.currentUser!.username!),
                      Text(globals.currentUser!.email!),
                    ],
                  ),
                ),
              ],
            ),

  // row scroll reference: https://stackoverflow.com/questions/46222788/how-to-create-a-row-of-scrollable-text-boxes-or-widgets-in-flutter-inside-a-list
            SizedBox(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: 
                    ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      //itemExtent: 20,
                      itemExtent: 100.0,
                      padding: EdgeInsets.all(5.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: globals.currentUser!.diaryCategory!.length + 1,
                      itemBuilder: (context, index) {
                        if (index ==
                            globals.currentUser!.diaryCategory!.length) {
                          // last item would be "add"
                          return 
                            Row(
                              crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
  // flutter icon list: https://www.fluttericon.cn/
  // AlertDialog with form input: https://www.dhiwise.com/post/how-to-create-and-customize-flutter-alert-dialogs
                            IconButton(
                              onPressed: () {
                                String alertDialogCategoryInput = "";
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('輸入新類別'),
                                      content: TextField(
                                        decoration: InputDecoration(
                                            hintText: "輸入新類別以分類世記"),
                                        onChanged: (text) {
                                          alertDialogCategoryInput =
                                              text;
                                        },
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Submit'),
                                          onPressed: () {
                                            // Handle the submit action
                                            service.updateUsersAddCategory(
                                                globals.currentUser!.id!,
                                                alertDialogCategoryInput);
                                            Navigator.of(context)
                                                .pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.add),
                              style: IconButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.lightBlue,
                                //textStyle: const TextStyle(fontSize: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(5),
                                ),
                              ),
                            )
                          ]);
                    } else {
                      // middle items in database
                      return Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // text button reference: https://api.flutter.dev/flutter/material/TextButton-class.html
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.lightBlue,
                              textStyle:
                                  const TextStyle(fontSize: 16.0),
                            ),
                            onPressed: () {},
                            icon: Image.asset(
                                'assets/images/diary.png',
                                width: 20.0),
                            label: Text(
                                globals.currentUser!.diaryCategory![index]),
                          ),
                        ],
                      );
                    }
                  })
                ),
              ),
            ),

  // UI reference: https://stackoverflow.com/questions/58117777/how-to-add-vertical-and-horizontal-line-around-flutter-grid-view
            Expanded(
                child: FutureBuilder<List<Diary>>(
                    future: fetchDiaryList(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List<Diary>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return GridView.builder(
                            //physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              crossAxisCount: 3,
                            ),
                            
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
  // click effect reference: https://stackoverflow.com/questions/43692923/flutter-container-onpressed
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewDiaryPage(
                                              currentDiaryId: snapshot.data![index].id!)),
                                    );
                                  },
                                  child: Ink(
                                    color: Colors.black,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
  // MediaQuery get device size: https://www.geeksforgeeks.org/flutter-set-custom-height-for-widget-in-gridview/
                                          width: MediaQuery.of(context).size.width / 3,
                                          height: (MediaQuery.of(context).size.width - 5/*buffer*/) / 3,
                                          child: DiaryPreview(
                                              diaryId: snapshot.data![index].id!),
                                        )
                                      ],
                                    ),
                                  ));
                            });
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasData &&
                          snapshot.data!.isEmpty) {
                        return GridView.builder(
                            //physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              crossAxisCount: 3,
                            ),
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return InkWell(
  // click effect reference: https://stackoverflow.com/questions/43692923/flutter-container-onpressed
                                  child: Ink(
                                    color: Colors.lightBlue,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(height: 50),
                                        Text("你還未創建首個世記!")
                                      ],
                                    ),
                                  ));
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }))
          ],
        ),
      )
    );
  }
}
