import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_diary/page/view_diary_page.dart';
import 'package:life_diary/src/widgets/diary_preview.dart';
import 'package:life_diary/utils/database_service.dart';
import 'package:life_diary/src/schema/users.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DatabaseService service = DatabaseService();
  Future<Users?>? currentUser;
  Users? retrievedUser;

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    currentUser = service.retrieveUsers(currentUserId);
    retrievedUser = await service.retrieveUsers(currentUserId);
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
      body: Column(
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
                    FutureBuilder(
                        future: currentUser,
                        builder: (BuildContext context,
                            AsyncSnapshot<Users?> snapshot) {
                          if (snapshot.hasData) {
                            return Text(retrievedUser!.username!);
                          } else {
                            return Text("");
                          }
                        }),
                    FutureBuilder(
                        future: currentUser,
                        builder: (BuildContext context,
                            AsyncSnapshot<Users?> snapshot) {
                          if (snapshot.hasData) {
                            return Text(retrievedUser!.email!);
                          } else {
                            return Text("");
                          }
                        })
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
                child: FutureBuilder(
                    future: currentUser,
                    builder:
                        (BuildContext context, AsyncSnapshot<Users?> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            //physics: NeverScrollableScrollPhysics(),
                            //itemExtent: 20,
                            itemExtent: 100.0,
                            padding: EdgeInsets.all(5.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: retrievedUser!.diaryCategory!.length + 1,
                            itemBuilder: (context, index) {
                              // if (index == 0)
                              // {
                              //   // first item would be "all"
                              //   return Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       TextButton.icon(
                              //         style: TextButton.styleFrom(
                              //           foregroundColor: Colors.black,
                              //           backgroundColor: Colors.lightBlue,
                              //           textStyle: const TextStyle(fontSize: 16.0),
                              //         ),
                              //         onPressed: (){

                              //         },
                              //         icon: Image.asset('assets/images/diary.png', width: 20.0),
                              //         label: Text("所有"),
                              //       )
                              //     ]
                              //   );
                              // }
                              // else
                              if (index ==
                                  retrievedUser!.diaryCategory!.length) {
                                // last item would be "add"
                                return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
//                                       TextButton.icon(
//                                         style: TextButton.styleFrom(
//                                             foregroundColor: Colors.black,
//                                             backgroundColor: Colors.lightBlue,
//                                             textStyle: const TextStyle(fontSize: 16.0),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(5),
//                                             ),
//                                           ),
//                                         onPressed: (){

//                                         },
// // flutter icon list: https://www.fluttericon.cn/
//                                         icon: Icon(Icons.add),
//                                         label: Text("test"),
//                                       )
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
                                                          currentUserId,
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
                                          retrievedUser!.diaryCategory![index]),
                                    ),
                                  ],
                                );
                              }
                            });
                      } else {
                        return Text("");
                      }
                    }),
              ),
            ),
          ),

// UI reference: https://stackoverflow.com/questions/58117777/how-to-add-vertical-and-horizontal-line-around-flutter-grid-view
          Expanded(
              child: FutureBuilder(
                  future: currentUser,
                  builder:
                      (BuildContext context, AsyncSnapshot<Users?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        retrievedUser!.diaryId!.isNotEmpty) {
                      return GridView.builder(
                          //physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            crossAxisCount: 3,
                          ),
                          
                          itemCount: retrievedUser!.diaryId!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
// click effect reference: https://stackoverflow.com/questions/43692923/flutter-container-onpressed
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewDiaryPage(
                                            currentDiaryId: retrievedUser!
                                                .diaryId![index])),
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
                                            diaryId:
                                                retrievedUser!.diaryId![index]),
                                      )
                                    ],
                                  ),
                                ));
                          });
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData &&
                        retrievedUser!.diaryId!.isEmpty) {
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
    );
  }
}
