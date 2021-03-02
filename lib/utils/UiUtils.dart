import 'package:flutter/material.dart';

class UiUtils {
  static showLoaderDialog(BuildContext context, String msg) {
    AlertDialog alert = AlertDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: new Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10,) ,
            Container(
              margin: EdgeInsets.only(left: 7),
              child: Expanded(
                child: Text(msg,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static showAlert(String title, String msg, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            FlatButton(
              onPressed: () =>
                  {Navigator.of(context, rootNavigator: true).pop('dialog')},
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static Widget getErrorWidget(String msg) {
    return Container(
      child: Text(msg),
    );
  }

 static hideLoader(BuildContext context) {
    Navigator.pop(context);
  }
}
