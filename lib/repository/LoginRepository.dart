import 'package:Restaurant_social_mobile_app/data/remote/FirebaseManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Restaurant_social_mobile_app/data/model/User.dart';

class LoginRepository {
  Future<UserResponse> loginUser(String email, String password) async {
    UserResponse userResponse = UserResponse();
    try {
      UserCredential data =
          await FirebaseManger.instance.loginUsingEmail(email, password);
      userResponse = UserResponse.mapFrom(data.user);
    } on FirebaseAuthException catch (e) {
      userResponse.failed = true;
      userResponse.error = e.message;
    }
    return userResponse;
  }

  Future<UserResponse> register(String email, String password) async {
    UserResponse userResponse = UserResponse();
    try {
      UserCredential data =
      await FirebaseManger.instance.registerUsingEmail(email, password);
      userResponse = UserResponse.mapFrom(data.user);
    } on FirebaseAuthException catch (e) {
      userResponse.failed = true;
      userResponse.error = e.message;
    }
    return userResponse;
  }

}
