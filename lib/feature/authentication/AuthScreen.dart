import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:Restaurant_social_mobile_app/feature/authentication/AuthenticationView.dart';
import 'package:Restaurant_social_mobile_app/feature/home/Home.dart';
import 'package:Restaurant_social_mobile_app/utils/UiUtils.dart';
import 'package:Restaurant_social_mobile_app/views/LoginView.dart';
import 'package:Restaurant_social_mobile_app/views/SignUpView.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AuthScreenState createState() => _AuthScreenState(true, title);
}

class _AuthScreenState extends State<AuthScreen> implements AuthenticationView {
  bool isLogin = false;
  final String title;
  _AuthScreenState(this.isLogin, this.title);
  hideLoader() {
    Navigator.pop(context);
  }

  getView(bool isLogin) {
    if (isLogin) {
      return LoginView(this);
    } else {
      return SignUpView(this);
    }
  }

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
                      getView(isLogin),
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

  @override
  onFailed(UserResponse response) {
    hideLoader();
    UiUtils.showAlert("Error", response.error, context);
  }

  @override
  onLoad(String msg) {
    UiUtils.showLoaderDialog(context, msg);
  }

  @override
  onSuccess(UserResponse response) {
    hideLoader();
    goToHome();
  }

  @override
  onclick(bool res) {
    setState(() {
      this.isLogin = res;
    });
  }

  void goToHome() {
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => HomeScreen(),
    ));
  }
}
