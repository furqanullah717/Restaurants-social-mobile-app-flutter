import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:Restaurant_social_mobile_app/feature/people/AddFriendView.dart';
import 'package:Restaurant_social_mobile_app/repository/FriendsRepository.dart';
import 'package:Restaurant_social_mobile_app/utils/Utils.dart';
import 'package:Restaurant_social_mobile_app/views/FriendListItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendsView extends StatefulWidget {
  final String location;

  FriendsView(this.location);

  @override
  State<StatefulWidget> createState() {
    return FriendsViewState(location);
  }
}

class FriendsViewState extends State<FriendsView> {
  final String location;
  final List<String> idsToExclude = List();
  FriendsRepository friendsRepository = new FriendsRepository();

  FriendsViewState(this.location) {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    idsToExclude.add(uuid);
    friendsRepository
        .getFriendsOfUser(uuid)
        .then((value) => {updateList(value, uuid)});
  }

  @override
  Widget build(BuildContext context) {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
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

        return Scaffold(
          body: getView(snapshot),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFriendView(idsToExclude),
                  ));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 29,
            ),
            backgroundColor: Colors.black,
            tooltip: 'Add Friend',
            elevation: 5,
            splashColor: Colors.grey,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  updateList(QuerySnapshot value, String uuid) {
    value.docs.forEach((element) {
      idsToExclude.add(element.data()["uuid"]);
    });
    friendsRepository.getRequestOfUser(uuid).then((data) => {
          data.docs.forEach((element) {
            idsToExclude.add(element.data()["uuid"]);
          })
        });
  }

  getView(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (Utils.isNullOrEmpty(snapshot)) {
      return Center(
        child: Text("No Data Found"),
      );
    }

    return ListView(
      children: snapshot.data.docs.map((DocumentSnapshot document) {
        UserResponse user = UserResponse.mapFromSnapshot(document);
        return FriendListItem(user);
      }).toList(),
    );
  }
}
