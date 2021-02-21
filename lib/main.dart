import 'package:Restaurant_social_mobile_app/widget/CustomButton.dart';
import 'package:Restaurant_social_mobile_app/widget/CustomTextField.dart';
import 'package:flutter/material.dart';

import 'widget/LoginToggleText.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
                      Container(
                        decoration:
                            BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(40),
                        child: Center(
                          child: Column(
                            children: [
                              CustomTextField("Username",
                                  TextInputType.emailAddress, false),
                              CustomTextField("Password",
                                  TextInputType.visiblePassword, true),
                              CustomButton(),
                              SizedBox(
                                height: 10,
                              ),
                              ToggleLogin("Don't Have account?", "Register",()=>{
                                print("Toggle clicked")
                              }),
                            ],
                          ),
                        ),
                      ),
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
