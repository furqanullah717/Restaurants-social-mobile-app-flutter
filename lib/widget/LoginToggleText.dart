import 'package:flutter/material.dart';

class ToggleLogin extends StatelessWidget {
  final String msg;
  final String button;
  final Function buttonClick;

  ToggleLogin(this.msg, this.button, this.buttonClick);

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
