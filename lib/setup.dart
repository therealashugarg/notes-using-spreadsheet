// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes/button.dart';
import 'package:notes/greeting.dart';
import 'package:notes/homepage.dart';
import 'package:notes/img.dart';
import 'package:notes/gsheets_api.dart';
import 'package:notes/service_account.dart';
import 'package:notes/setup_text.dart';

class UserSetup extends StatefulWidget {
  // UserSetup({required this.spreadSheetId, required this.sheetNo});

  @override
  State<UserSetup> createState() => _UserSetupState();
}

class _UserSetupState extends State<UserSetup> {
  TextEditingController spreadSheetId = TextEditingController();
  TextEditingController sheetNo = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spreadSheetId.addListener(() => setState(() {}));
    sheetNo.addListener(() => setState(() {}));
  }

  void callApi() {
    WidgetsFlutterBinding.ensureInitialized();
    GoogleSheetsApi(
            spreadsheetId: spreadSheetId.text,
            worksheet: int.parse(sheetNo.text))
        .init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 30),
            Padding(padding: const EdgeInsets.all(20.0), child: Greeting()),
            SizedBox(height: 25),
            Column(children: [
              // information for user referance
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffd7dede)),
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: reusableText(
                                'Refer the below images and enter the credentials correctly. Copy the below given service account and share your spreadsheet with this account, Don\'t worry your data is not shared with anyone.'),
                          ),
                          SizedBox(height: 15),
                          MyImage(path: 'assets/images/sharewith.png'),
                          MyImage(path: 'assets/images/spreadsheet_id.png'),
                          MyImage(path: 'assets/images/sheet_no.png'),
                          SizedBox(height: 15)
                        ])),
                  )),
              SizedBox(height: 15),
              ServiceAccount(),
            ]),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  // input spreadsheet ID
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: spreadSheetId,
                          decoration: InputDecoration(
                              // prefix person icon
                              prefixIcon: Icon(Icons.sticky_note_2_outlined),
                              // suffix clear icon
                              suffixIcon: spreadSheetId.text.isEmpty
                                  ? Container(width: 0)
                                  : IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () => spreadSheetId.clear()),
                              // field editing
                              hintText: "Spreadsheet ID",
                              labelText: 'Spreadsheet ID',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))))),
                  // input worksheet no.
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          controller: sheetNo,
                          decoration: InputDecoration(
                              // prefix person icon
                              prefixIcon:
                                  Icon(Icons.format_list_bulleted_rounded),
                              // suffix clear icon
                              suffixIcon: sheetNo.text.isEmpty
                                  ? Container(width: 0)
                                  : IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () => sheetNo.clear()),
                              // field editing
                              hintText: "Sheet No.",
                              labelText: 'Sheet No.',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))))),
                  // Submit Button
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: MyButton(
                          text: 'Submit',
                          function: () {
                            callApi();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }))
                ]))
          ]),
        ));
  }
}
