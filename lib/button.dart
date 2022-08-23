// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final text;
  final function;

  MyButton({this.text, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Color(0XFF1c1e1f)),
        child: Center(
            child: Text(text,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white))),
      ),
    );
  }
}
