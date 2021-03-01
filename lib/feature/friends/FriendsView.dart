import 'package:Restaurant_social_mobile_app/data/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FriendsView extends StatelessWidget {
  final String location;

  FriendsView(this.location);

  final TextStyle headStyle = TextStyle(
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
      fontSize: 20);

  final TextStyle style = TextStyle(color: Colors.black45, fontSize: 16);

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
        if (snapshot.data == null ||
            snapshot.data.docs == null ||
            snapshot.data.docs.length == 0) {
          return Container(
            child: Text("No Data Found"),
          );
        }

        return Scaffold(
          body: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
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
                                borderRadius: BorderRadius.circular(25)),
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
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
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
}
