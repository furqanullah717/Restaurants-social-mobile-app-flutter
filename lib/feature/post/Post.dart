import 'package:Restaurant_social_mobile_app/feature/post/PostData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostView extends StatelessWidget {
  Future<QuerySnapshot> getUserDetails() async {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    final CollectionReference reference = FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("request");
    return reference.get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getUserDetails(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        List<String> ids = new List();
        snapshot.data.docs.forEach((element) {
          ids.add(element.data()["uuid"]);
        });
        CollectionReference users = FirebaseFirestore.instance.collection('posts');
       users.where('userid', whereIn: ids);

        return new PostData(ids);
      },
    );
  }
}
