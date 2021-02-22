import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg_login.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10),
                  child: Wrap(
                    children: [
                      Text("This is home screen"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
