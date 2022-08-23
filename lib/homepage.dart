// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:notes/button.dart';
import 'package:notes/gsheets_api.dart';
import 'package:notes/loading.dart';
import 'package:notes/open_notepage.dart';
import 'package:notes/setup.dart';
import 'package:notes/textbox.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController noteText = TextEditingController();
  Future<void> _handleRefresh() async {
    // reloading take some time..
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    noteText.addListener(() => setState(() {}));
  }

  void _post() {
    GoogleSheetsApi.insert(noteText.text);
    noteText.clear();
  }

  void startLoading() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel;
      }
    });
  }

  // void onNoteDelete() {
  //   setState(() {
  //     GoogleSheetsApi.deleteCell(idDelete: idD);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => HomePage()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.loading == true) {
      startLoading();
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('N O T E S', style: TextStyle(color: Color(0XFF1c1e1f))),
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => UserSetup())));
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded)),
          backgroundColor: Color(0xffd7dede),
          elevation: 0,
        ),
        body: LiquidPullToRefresh(
          onRefresh: _handleRefresh,
          color: Color(0xffd7dede),
          backgroundColor: Colors.white,
          height: 250,
          animSpeedFactor: 2,
          showChildOpacityTransition: false,
          child: Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: GoogleSheetsApi.loading == true
                    ? LoadingAnimation()
                    : ListView.builder(
                        itemCount: GoogleSheetsApi.currentNotes.length,
                        itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              String data = GoogleSheetsApi.currentNotes[index];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotePage(data: data, id: index)));
                            },
                            child: Slidable(
                              startActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [],
                              ),
                              child: MyTextBox(
                                  noteText:
                                      GoogleSheetsApi.currentNotes[index]),
                            ))),
              ),
              // bottom part
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          controller: noteText,
                          decoration: InputDecoration(
                              // prefix person icon
                              prefixIcon: Icon(Icons.sticky_note_2_outlined),
                              // suffix clear icon
                              suffixIcon: noteText.text.isEmpty
                                  ? Container(width: 0)
                                  : IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () => noteText.clear()),
                              // field editing
                              hintText: "Enter...",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(
                      text: 'POST',
                      function: _post,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
