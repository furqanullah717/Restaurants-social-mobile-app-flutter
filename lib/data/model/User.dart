import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserResponse {
  String username;
  String uuid;
  String profilePic;
  String error;
  bool failed = false;
  String name;
  UserResponse();

  UserResponse.mapFrom(User user) {
    this.username = user.email;
    this.profilePic = user.photoURL;
    this.uuid = user.uid;
    this.name = user.displayName;
  }

  UserResponse.mapFromSnapshot(DocumentSnapshot user) {
    this.username = user['username'];
    this.profilePic =user['profilePic'];
    this.uuid = user['uuid'];
    this.name = user['name'];
  }

  Map<String, dynamic> toJson() =>
      {'username': username, 'uuid': uuid, 'profilePic': profilePic, 'name':name};
}
