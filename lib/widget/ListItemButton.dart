import 'package:flutter/material.dart';

class ListItemButton extends StatelessWidget {
  final Function onClick;
  final Color color;
  final String text;

  ListItemButton(this.onClick, this.color, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(color: this.color, borderRadius: BorderRadius.circular(10)),
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        onPressed:onClick,
      ),
    );
  }
}
