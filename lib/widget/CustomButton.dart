

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.orange),
      margin: EdgeInsets.only(top: 10),
      child: Expanded(
        child: FlatButton(
          onPressed: () => {},
          child: (Text(
            "Login",
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
