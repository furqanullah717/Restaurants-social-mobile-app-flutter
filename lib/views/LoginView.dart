import 'package:Restaurant_social_mobile_app/widget/CustomButton.dart';
import 'package:Restaurant_social_mobile_app/widget/CustomTextField.dart';
import 'package:Restaurant_social_mobile_app/widget/LoginToggleText.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final Function onclick;

  LoginView(this.onclick);

  getClick() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(100, 0, 0, 0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            CustomTextField("Username", TextInputType.emailAddress, false),
            CustomTextField("Password", TextInputType.visiblePassword, true),
            CustomButton("Login", this.getClick),
            SizedBox(
              height: 10,
            ),
            ToggleLogin(
                "Don't Have account? ", "Register", () => {onclick(false)}),
          ],
        ),
      ),
    );
  }
}
