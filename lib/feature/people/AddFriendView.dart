import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:Restaurant_social_mobile_app/repository/FriendsRepository.dart';
import 'package:Restaurant_social_mobile_app/utils/Styles.dart';
import 'package:Restaurant_social_mobile_app/utils/UiUtils.dart';
import 'package:Restaurant_social_mobile_app/widget/ImageView.dart';
import 'package:Restaurant_social_mobile_app/widget/ListItemButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddFriendView extends StatefulWidget {
  final List<String> idsToExclude;

  AddFriendView(this.idsToExclude);

  @override
  State<StatefulWidget> createState() {
    return AddFriendState(idsToExclude);
  }
}

class AddFriendState extends State<AddFriendView> {
  final List<String> idsToExclude;
  FriendsRepository repository = FriendsRepository();

  AddFriendState(this.idsToExclude);

  updateState(UserResponse user) {
    UiUtils.hideLoader(context);
    this.setState(() {
      idsToExclude.add(user.uuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Friends',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(child: getView()),
    );
  }

  getView() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (snapshot.data == null ||
            snapshot.data.docs == null ||
            snapshot.data.docs.length == 0) {
          return Container(
            child: Text("No Data Found"),
          );
        }
        List<QueryDocumentSnapshot> docs = snapshot.data.docs;
        if (idsToExclude.isNotEmpty)
          docs.removeWhere((element) => checkIfContains(element));
        if (docs.length == 0) {
          return Container(
            child: Text("No Data Found"),
          );
        }
        return new ListView(
          children: docs.map((DocumentSnapshot document) {
            UserResponse user = UserResponse.mapFromSnapshot(document);
            return new Card(
                child: Container(
              margin: EdgeInsets.all(10),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ImageView(user.profilePic),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Flex(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          direction: Axis.vertical,
                          children: [
                            Text(
                              user.name,
                              style: Styles.headStyle,
                            ),
                            Text(
                              user.username,
                              style: Styles.style,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ListItemButton(
                                () => {addFriend(user)}, Colors.green, "Add"),
                          ],
                        ))
                  ],
                ),
              ),
            ));
          }).toList(),
        );
      },
    );
  }

  bool checkIfContains(element) {
    String uuid = element.data()["uuid"];
    return idsToExclude.contains(uuid);
  }

  addFriend(UserResponse user) {
    UiUtils.showLoaderDialog(
        context, "Please wait while we add your request..");
    UserResponse userResponse =
        UserResponse.mapFrom(FirebaseAuth.instance.currentUser);
    repository
        .getRequestRef(user.uuid)
        .add(userResponse.toJson())
        .then((value) => {updateState(user)});
  }
}
