import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManger {
  static final FirebaseManger instance = FirebaseManger._internal();

  factory FirebaseManger() {
    return instance;
  }

  FirebaseManger._internal();

  Future<UserCredential> loginUsingEmail(String email, String passowrd) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: passowrd);
  }

  Future<UserCredential> registerUsingEmail(String email, String passowrd) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: passowrd);
  }

  UserResponse getCurrentUser() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return UserResponse.mapFrom(user);
    }
    return null;
  }
}
