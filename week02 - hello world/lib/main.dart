// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(                                                         // display header of application
          title: const Text(
            'Week02Exercise - Solution'),
        ),
        body: const Center(                                                     // display main context (body) of application
          child: Text(
            'Hello World!',
            style: TextStyle( fontSize: 26),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}