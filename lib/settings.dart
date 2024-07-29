import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(18.0),
          child: Text(
            "Theme",
            style: TextStyle(fontSize: 19.0),
          )),
    );
  }
}
