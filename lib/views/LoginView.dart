import 'package:Restaurant_social_mobile_app/feature/authentication/AuthenticationView.dart';
import 'package:Restaurant_social_mobile_app/repository/LoginRepository.dart';
import 'package:Restaurant_social_mobile_app/utils/UiUtils.dart';
import 'package:Restaurant_social_mobile_app/widget/CustomButton.dart';
import 'package:Restaurant_social_mobile_app/widget/CustomTextField.dart';
import 'package:Restaurant_social_mobile_app/widget/LoginToggleText.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final AuthenticationView callback;
  final _form = GlobalKey<FormState>();

  LoginView(this.callback);

  getClick() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    callback.onLoad("Signing in...");
    var res = await LoginRepository()
        .loginUser(userNameController.text, passwordController.text);
    if (res.failed) {
      callback.onFailed(res);
    } else {
      callback.onSuccess(res);
    }
  }

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
        child: Form(
          key: _form,
          child: getView(),
        ),
      ),
    );
  }

  getView() {
    return Column(children: [
      CustomTextField(
          "Username", TextInputType.emailAddress, false, userNameController,
          (text) {
        if (!UiUtils.isValidEmail(text)) {
          return "Enter a valid Email Address!";
        }
        return null;
      }),
      CustomTextField(
          "Password", TextInputType.visiblePassword, true, passwordController,
          (text) {
        if ((text.length < 5)) {
          return "Password must me at least 6 character long";
        }
        return null;
      }),
      CustomButton("Login", this.getClick),
      SizedBox(
        height: 10,
      ),
      ToggleLogin(
          "Don't Have account? ", "Register", () => {callback.onclick(false)}),
    ]);
  }
}
