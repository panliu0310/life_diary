import 'package:flutter/material.dart';
import 'package:life_diary/page/create_page.dart';
import '../../page/profile_page.dart';
import '../../page/story_page.dart';
import '../../page/setting_page.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() =>
      _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState
    extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  // List<Widget> _widgetOptions = [
  //   StoryPage(),
  //   CreateDiaryPage(currentUser: currentUser),
  //   ProfilePage(),
  //   SettingPage()
  // ];
  GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
      List<Widget> widgetOptions = [
      StoryPage(),
      CreatePage(),
      ProfilePage(),
      SettingPage()
    ];
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
        backgroundColor: Colors.lightBlue,
      ),*/
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: globalKey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Story',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
