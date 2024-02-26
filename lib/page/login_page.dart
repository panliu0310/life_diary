import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  
                },
                child: Text('Test'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {

                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}