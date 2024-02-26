import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget
{
@override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Text('Settings'),
            const SignOutButton(),
          ],
        ),
    );
  }
}