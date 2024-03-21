import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: currentUser,
                      builder:
                        (BuildContext context, AsyncSnapshot<Users?> snapshot) {
                          if (snapshot.hasData)
                          {
                            return Text(retrievedUser!.username!);
                          }
                          else
                          {
                            return Text("");
                          }
                        }
                    ),
                    FutureBuilder(
                      future: currentUser,
                      builder:
                        (BuildContext context, AsyncSnapshot<Users?> snapshot) {
                          if (snapshot.hasData)
                          {
                            return Text(retrievedUser!.email!);
                          }
                          else
                          {
                            return Text("");
                          }
                        }
                    )
                  ],
                ),
              ),
            ],
          ),


          Padding(
            padding: EdgeInsets.only(left: 35, bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Text("test"),
               SizedBox(width: 50),
               Text("test"),
               SizedBox(width: 50),
               Text("test"),
              ],
            ),
          ),

// UI reference: https://stackoverflow.com/questions/58117777/how-to-add-vertical-and-horizontal-line-around-flutter-grid-view
          Expanded(
            child: FutureBuilder(
              future: currentUser,
              builder:
                (BuildContext context, AsyncSnapshot<Users?> snapshot) {
                  if (snapshot.hasData && retrievedUser!.diaryId!.isNotEmpty){
                    return GridView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: 3,
                      ),
                      itemCount: retrievedUser!.diaryId!.length,
                      itemBuilder: (context, index) {
                        return Container(color: Colors.black);
                      }
                    );
                  }
                  else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData &&
                    retrievedUser!.diaryId!.isEmpty) {
                    return GridView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: 3,
                      ),
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        return Container(color: Colors.black);
                      }
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            )
          )
        ],
      ),
    );
  }
}