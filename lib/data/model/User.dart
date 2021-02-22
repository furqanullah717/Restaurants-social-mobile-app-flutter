import 'package:firebase_auth/firebase_auth.dart';

class UserResponse {
  String username;
  String uuid;
  String profilePic;
  String error;
  bool failed = false;
  UserResponse();

  UserResponse.mapFrom(User user ){
    this.username =  user.email;
    this.profilePic =  user.photoURL;
    this.uuid = user.uid;
  }
}