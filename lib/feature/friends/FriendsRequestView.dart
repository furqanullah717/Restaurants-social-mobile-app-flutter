import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:Restaurant_social_mobile_app/repository/FriendsRepository.dart';
import 'package:Restaurant_social_mobile_app/utils/UiUtils.dart';
import 'package:Restaurant_social_mobile_app/utils/Utils.dart';
import 'package:Restaurant_social_mobile_app/views/FriendRequestListItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsRequestView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FriendRequestStat();
  }
}

class FriendRequestStat extends State<FriendsRequestView> {
  FriendsRepository repository = FriendsRepository();

  addUser(UserResponse user, String uuid) {
    return repository.addAsFriend(user, uuid);
  }

  void acceptRequest(UserResponse user, String id) {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    UiUtils.showLoaderDialog(
        context, "Please wait while we Accept your request..");
    addUser(user, uuid).then((value) => {
          addUser(UserResponse.mapFrom(FirebaseAuth.instance.currentUser),
                  user.uuid)
              .then((value) => {
                    repository
                        .deleteRequest(id)
                        .then((value) => {updateState()})
                  })
        });
  }

  updateState() {
    UiUtils.hideLoader(context);
    this.setState(() {});
  }

  void rejectFriendRequest(UserResponse user, String id) {
    UiUtils.showLoaderDialog(
        context, "Please wait while we Reject your request..");
    repository.deleteRequest(id).then((value) => {updateState()});
  }

  @override
  Widget build(BuildContext context) {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("request");
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (Utils.isNullOrEmpty(snapshot)) {
          return UiUtils.getErrorWidget("No Data Found");
        }
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            String id = document.id;
            UserResponse user = UserResponse.mapFromSnapshot(document);
            return FriendRequestListItem(user, id, acceptRequest, rejectFriendRequest);
          }).toList(),
        );
      },
    );
  }
}
