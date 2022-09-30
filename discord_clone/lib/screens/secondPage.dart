import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Second Screen",
        home: Scaffold(
            appBar: AppBar(title: Text("SecondScreen")),
            body: Center(
                child: TextButton(
              child: Text("Go back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ))));
  }
}
