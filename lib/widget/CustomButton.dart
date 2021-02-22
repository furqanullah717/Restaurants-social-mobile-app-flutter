import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Function callBack;

  CustomButton(this.name, this.callBack);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(15.0),),
      margin: EdgeInsets.only(top: 10),
      child:  FlatButton(
          onPressed: callBack(),
          child: (Text(
            name,
            style: TextStyle(color: Colors.white),
          )),
        ),
    );
  }
}
