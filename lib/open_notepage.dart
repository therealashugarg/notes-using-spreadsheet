
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes/gsheets_api.dart';
import 'package:notes/homepage.dart';

class NotePage extends StatefulWidget {
  @override
  String data;
  int id;
  NotePage({required this.data, required this.id});
  State<NotePage> createState() => _NotePageState(noteText: data, id: id);
}

class _NotePageState extends State<NotePage> with WidgetsBindingObserver {
  final FocusNode inputFocusNode = FocusNode();
  bool _isEditingText = false;
  TextEditingController _editingController = TextEditingController();

  String noteText;
  int id;
  _NotePageState({required this.noteText, required this.id});

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: noteText);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _editingController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    inputFocusNode.dispose();
    super.dispose();
  }

  onNoteSubmit() {
    setState(() {
      noteText = _editingController.text;
      _isEditingText = false;
      GoogleSheetsApi.updateCell(id: id, value: _editingController.text);
    });
  }

  onNoteDelete() {
    setState(() {
      GoogleSheetsApi.deleteCell(idDelete: id);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('N O T E S', style: TextStyle(color: Color(0XFF1c1e1f))),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: onNoteSubmit,
            icon: Icon(Icons.done),
          ),
          IconButton(
            onPressed: onNoteDelete,
            icon: Icon(Icons.delete),
          ),
        ],
        elevation: 0,
      ),
      body: Center(child: EditableTFW()),
    );
  }

  Widget EditableTFW() {
    if (_isEditingText) {
      return Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 15, left: 15, right: 15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Color(0xffd7dede),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onSubmitted: (newValue) {
                  setState(() {
                    noteText = newValue;
                    _isEditingText = false;
                    GoogleSheetsApi.updateCell(id: id, value: newValue);
                  });
                },
                focusNode: inputFocusNode,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                autofocus: true,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(border: InputBorder.none),
                controller: _editingController,
              ),
            ),
          ),
        ),
      );
    }
    return GestureDetector(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 15, left: 15, right: 15),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Color(0xffd7dede),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 25, bottom: 12),
                    child: Text(noteText, style: TextStyle(fontSize: 18))))));
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance.window.viewInsets.bottom;
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      if (value == 0) {
        inputFocusNode.unfocus();
      }
    }
  }
}
