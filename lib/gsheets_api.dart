// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  final String spreadsheetId;
  final int worksheet;

  GoogleSheetsApi({required this.spreadsheetId, required this.worksheet});

  // create credentials
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "flutter-gsheets-notes-353217",
    "private_key_id": "d750752ce39a09f95ffd0c144a9feef6e9122fdc",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCxhl2adAtmbZID\nXJECpz58l/Q7Fg4TC4tmD1Lxk2WuP5cWeQIMN2d33cPx1NmkTwqssO3oGigA58IU\nRwYiy2JNptnWwlVPw4DzVJfuPsLg5A1cYsIEqf2Jc/nhjrcSfod1+tpDiWCIYe3U\nbXdmftGLDG2em5BYhrKLLRrHkaZB44sSurH511fKj0MfKovQpTGz73Tdyc7DisTz\nxXliuVaNdEyIS88B/Woi32+0gRX2fofYjwKnbZ2eyBnzGOx2ds4EdlIab3k+nOqX\nLkn+T/BvC8hMvrmca8uHd6uRZA530L3/IdmFQ9C9s/9r9B56AtK8xXsn64n/fbI9\npqHOajaVAgMBAAECggEAB7uCv9bs8pg0Zo5IoeUnaDi1YnSsExF+QxxikE0x5GyD\ndNVU5oCFsqEa1Af7NuUoFN+POhXkxvoeG2rNWwShRbqa/US+GVkg3vh0HOROi4pd\nBQVam00AOYivFxXaGYvs88TQ1WVz3ZAbOOG2J37zB57ew3k8YohZ2VmsmfBZKo0S\npGbD2NdUwWAUZ5ds96yQYs7gVVvZ43lTG4Ng5fgBxg3ZIwWt1rQODk7W5OLhQWL5\nCKmNBUMcmsZIh8W/k0y2VHfZA4l6vx8yyK9FoKUcrv5jDVjjcG8uWQOpfhJOb689\nBe1x9sWFyqgO7QmS6IvH35OBcKICBgGzc6j8PCpg3QKBgQDu4EutMqkenpbNGBZ0\nxuVUdfNo+9dvUW4tOhzeeZ3kqqj6MvTrcDF23oyqEUQl9Gz+FP3DeG49yfFnWTti\nDP+oPvFTamLxb48ImywGmiKEwro8ZrLAgN6X6hopLO5VbmAwq57anocONr56TsW2\n2oneYsB/m2wn2HiUGKlx6SJvcwKBgQC+QDCdd2KrHAEgO8ogMcVPtkHuH6pyBCUm\nWT6+/AnD4jfjiV7Gep1yKsq6QUYuBlEZ8q+/mpn58ohhPQ7C+kpb2anhvYveS7/+\nzNB2hCmkfBmwlWTiA1YRbd613+UvZajhFxjlctz+fS3ytkqopeK0BOpK3f6LWZsu\nxk0+pLWv1wKBgQCAyvAifukOOEVoaS9aYQ6uvjWyCe769vWnbui3zuyhqJ4Y4DaL\nZl9VDuLaoxqSODo3uAumQ510tRfyN/s7f3SsOtuUtQyJzjNZWYigOqSX3gHZpSmF\nfzYExFS8lJwf9bXpJ+8rQkPhFwUWHridQTEKdUYCx0LGLQG+H5nkb+WAHwKBgQCj\nEImarfUYDAy7AAQizAX+aIzh+Koyx3LAB8ZME+Kazo5wrBFbtUS10g+ozMHGOQvS\nXbxdUbmgDkzua1L3s2eAinOdVMVJZ0vMrOgQbP70SJoMTEAHqCxhC/bTlG/vzAaP\nxyhDocvhJJH5cl1TZ7uD6KKYQOYnskncMYOLqclASQKBgQDWpUwSSImbzcfg8rBs\n1/M4hjzp1Pexj5SulvGMB+L6rJ+5R/a5LeVigvPHe0Ouci8gEdjX7M5S6zyr+Ip5\nMBA2buwMp3lEr7s0wwnAinR/XRwtnQRHy1UvUSXZJvmoJAKdNKj5NGHO/v9FUEsU\nFJ8Frb+baW0LE5f8iQ7qsH+rvg==\n-----END PRIVATE KEY-----\n",
    "client_email": "flutter-gsheets-notes@flutter-gsheets-notes-353217.iam.gserviceaccount.com",
    "client_id": "111355328620861587641",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-notes%40flutter-gsheets-notes-353217.iam.gserviceaccount.com"
  }
  ''';

  // setup and connect to the spreadsheet
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  //some variable to keep track of..
  static int numberOfNotes = 0;
  static List<String> currentNotes = [];
  static bool loading = true;

  // initialise the spreadsheet
  Future init() async {
    final ss = await _gsheets.spreadsheet(spreadsheetId);
    _worksheet = ss.worksheetByIndex(worksheet - 1);
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: numberOfNotes + 1)) !=
            '') {
      numberOfNotes++;
    }
    loadNotes();
  }

  // load existing notes from the spreadsheets
  static Future loadNotes() async {
    if (_worksheet == null) return;

    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);
      if (currentNotes.length < numberOfNotes) {
        currentNotes.add(newNote);
      }
    }

    loading = false;
  }

  // insert a new note
  static Future insert(String note) async {
    if (_worksheet == null) return;
    numberOfNotes++;
    currentNotes.add(note);
    await _worksheet!.values.appendRow([note]);
  }

  static Future updateCell({
    required int id,
    required dynamic value,
  }) async {
    if (_worksheet == null) return false;
    currentNotes[id] = value;
    await _worksheet!.values.insertValue(value, column: 1, row: id + 1);
  }

  static Future deleteCell({int? idDelete}) async {
    if (_worksheet == null) return false;
    currentNotes.removeAt(idDelete!);
    await _worksheet!.deleteRow(idDelete + 1);
    numberOfNotes--;
  }
}
