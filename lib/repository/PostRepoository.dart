import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostRepository {
  Future<QuerySnapshot> getUserFriendList() async {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference reference = FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("friends");
    return reference.get();
  }

  getListOfFriendsPost(List<String> ids) {
    CollectionReference users = FirebaseFirestore.instance.collection('posts');
    users.where('userid', whereIn: ids);
    return users;
  }
}
