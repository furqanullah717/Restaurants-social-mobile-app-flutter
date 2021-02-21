import 'package:flutter/material.dart';

class ToggleLogin extends StatelessWidget {
  String msg;
  String button;
  Function buttonClick;

  ToggleLogin(String msg, String button, Function buttonClick) {
    this.msg = msg;
    this.button = button;
    this.buttonClick = buttonClick;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.msg,
            style: TextStyle(color: Colors.white),
          ),
          InkWell(
            child: Text(
              this.button,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            onTap: this.buttonClick,
          )
        ],
      ),
    );
  }
}
