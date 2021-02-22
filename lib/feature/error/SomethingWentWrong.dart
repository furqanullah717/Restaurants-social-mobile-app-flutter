import 'package:flutter/material.dart';

class SomeThingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.orange),
        child: Center(
          child: Wrap(
            children: [
              Text(
                "Something went Wrong",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
