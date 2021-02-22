import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextInputType textInputType;
  final bool obscureText;
  final TextEditingController textController;
  final Function validator;

  CustomTextField(
      this.hint, this.textInputType, this.obscureText, this.textController,this.validator);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Center(
          child: TextFormField(
            validator:validator ,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
            ),
            style: TextStyle(color: Colors.black54, fontSize: 16),
            keyboardType: textInputType,
            controller: textController,
          ),
        ));
  }
}
