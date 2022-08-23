// ignore_for_file: prefer_const_constructors

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ServiceAccount extends StatefulWidget {
  const ServiceAccount({Key? key}) : super(key: key);

  @override
  State<ServiceAccount> createState() => _ServiceAccountState();
}

class _ServiceAccountState extends State<ServiceAccount> {
  final String shareWith =
      'flutter-gsheets-notes@flutter-gsheets-notes-353217.iam.gserviceaccount.com';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffd7dede), borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 15, bottom: 10, right: 12),
          child: Row(
            children: [
              Expanded(
                  child: Text(shareWith,
                      style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500))),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Material(
                  child: InkWell(
                    hoverColor: Color(0xffd7dede),
                    child: IconButton(
                        constraints:
                            BoxConstraints(minHeight: 45, minWidth: 45),
                        splashColor: Color(0xffd7dede),
                        color: Colors.blueGrey,
                        onPressed: () => setState(() async {
                              await FlutterClipboard.copy(shareWith);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('✓  Copied Service Account')),
                              );
                            }),
                        icon: Icon(Icons.copy)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
