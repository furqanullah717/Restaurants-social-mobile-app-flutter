import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsView extends StatelessWidget {
  final String location;

  FriendsView(this.location);

  @override
  Widget build(BuildContext context) {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users')
        .doc(uuid)
        .collection(location);
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              leading: Icon(Icons.supervised_user_circle_rounded),
              title: new Text(document.data()['username']),
              subtitle: new Text(document.data()['uuid']),
            );
          }).toList(),
        );
      },
    );
  }
}
