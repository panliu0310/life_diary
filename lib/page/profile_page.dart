import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("username"),
                    Text("email")
                  ],
                ),
              ),
            ],
          ),


          Padding(
            padding: EdgeInsets.only(left: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
              ],
            ),
          ),

// UI reference: https://stackoverflow.com/questions/58117777/how-to-add-vertical-and-horizontal-line-around-flutter-grid-view
          Expanded(
            child: GridView.builder(
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
            )
          ),
        ],
      ),
    );
  }
}