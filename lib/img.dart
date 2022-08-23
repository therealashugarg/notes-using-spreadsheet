// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  String path;
  MyImage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(2, 2),
              ),
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(-2, -2),
              ),
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15), child: Image.asset(path))),
    );
  }
}
