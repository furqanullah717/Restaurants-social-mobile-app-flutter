import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendsRepository {
  DocumentReference getReference(String id) {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("request")
        .doc(id);
  }

  addAsFriend(UserResponse user, String uuid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("friends")
        .add(user.toJson());
  }

  deleteRequest(String id) {
    return getReference(id).delete();
  }

  getUserByUuid(String uuid) {
    return FirebaseFirestore.instance.collection("users").doc(uuid);
  }

  getFriendsOfUser(String uuid) {
    return getUserByUuid(uuid).collection("friends").get();
  }

  getRequestOfUser(String uuid) {
    return getUserByUuid(uuid).collection("request").get();
  }
  CollectionReference getRequestRef(String uuid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("request");
  }
}
