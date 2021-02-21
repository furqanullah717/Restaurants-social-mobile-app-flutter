import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hint;
  TextInputType textInputType;
  bool obscureText = true;

  CustomTextField(String hint, TextInputType textInputType, bool obscureText) {
    this.hint = hint;
    this.textInputType = textInputType;
    this.obscureText = obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical:0, horizontal: 10),
        child: Center(
          child: TextFormField(
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
            ),
            style: TextStyle(color: Colors.black54, fontSize: 16),
            keyboardType: textInputType,
          ),
        ));
  }
}
