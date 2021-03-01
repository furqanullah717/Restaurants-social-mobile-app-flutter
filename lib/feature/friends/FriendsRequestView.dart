import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:Restaurant_social_mobile_app/utils/UiUtils.dart';
import 'package:Restaurant_social_mobile_app/widget/ListItemButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FriendsRequestView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FriendRequestStat();
  }
}

class FriendRequestStat extends State<FriendsRequestView> {
  final TextStyle headStyle = TextStyle(
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
      fontSize: 20);

  final TextStyle style = TextStyle(color: Colors.black45, fontSize: 16);

  DocumentReference getReference(String id) {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("request")
        .doc(id);
  }

  void Accept(UserResponse user, String id) {
    String uuid = FirebaseAuth.instance.currentUser.uid;
    UiUtils.showLoaderDialog(
        context, "Please wait while we Accept your request..");
    FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("friends")
        .add(user.toJson())
        .then((value) => {
              getReference(id).delete().then((value) => {updateState()})
            });
  }

  updateState() {
    hideLoader();
    this.setState(() {});
  }

  hideLoader() {
    Navigator.pop(context);
  }

  void Reject(UserResponse user, String id) {
    UiUtils.showLoaderDialog(
        context, "Please wait while we Rejct your request..");
    getReference(id).delete().then((value) => {updateState()});
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

        if (snapshot.data == null ||
            snapshot.data.docs == null ||
            snapshot.data.docs.length == 0) {
          return Container(
            child: Text("No Data Found"),
          );
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            String id = document.id;
            UserResponse user = UserResponse.mapFromSnapshot(document);
            return new Card(
                child: Container(
              margin: EdgeInsets.all(10),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(200)),
                        height: 50,
                        width: 50,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Expanded(
                                child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: user.profilePic,
                                    fit: BoxFit.fitWidth),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              style: headStyle,
                            ),
                            Text(
                              user.username,
                              style: style,
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
                            ListItemButton(() => {Accept(user, id)},
                                Colors.green, "Accept"),
                            SizedBox(
                              height: 5,
                            ),
                            ListItemButton(
                                () => {Reject(user, id)}, Colors.red, "Reject"),
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
}
