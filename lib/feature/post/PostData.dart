import 'package:Restaurant_social_mobile_app/data/model/PostModel.dart';
import 'package:Restaurant_social_mobile_app/feature/post/PostCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostData extends StatelessWidget {
  final List<String> ids;

  PostData(this.ids);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('posts');
    if (ids.isNotEmpty) users.where('userid', whereIn: ids);
    return FutureBuilder(
        future: users.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new PostCard(PostModel.mapFrom(document.data()));
          }).toList());
        });
  }
}
