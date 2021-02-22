import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.orange),
      child: Center(
        child: Wrap(
          children: [
            Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
