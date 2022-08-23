// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes/setup.dart';


void main() {
  runApp(MyNotes());
}

class MyNotes extends StatelessWidget {
  const MyNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: UserSetup(),
    );
  }
}
