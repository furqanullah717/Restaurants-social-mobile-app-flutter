import 'package:Restaurant_social_mobile_app/data/model/PostModel.dart';
import 'package:Restaurant_social_mobile_app/feature/post/PostCard.dart';
import 'package:Restaurant_social_mobile_app/feature/post/addPost/AddPost.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostData extends StatefulWidget {
  final List<String> ids;

  PostData(this.ids);

  @override
  _PostDataState createState() => _PostDataState(ids);
}

class _PostDataState extends State<PostData> {
  final List<String> ids;

  _PostDataState(this.ids);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('posts');
    if (ids.isNotEmpty) users.where('userid', whereIn: ids);
    return Scaffold(
      body: FutureBuilder(
          future: users.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return getView(snapshot);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
          final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
          final firstCamera = cameras.first;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TakePictureScreen(
                  camera: firstCamera,
                ),
              ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 29,
        ),
        backgroundColor: Colors.black,
        tooltip: 'Add Post',
        elevation: 5,
        splashColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  createView(AsyncSnapshot<QuerySnapshot> snapshot) async {
    ;
  }

  getView(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.data == null ||
        snapshot.data.docs == null ||
        snapshot.data.docs.length == 0) {
      return Center(
        child: Text("No Data Found"),
      );
    }
    return ListView(
        children: snapshot.data.docs.map((DocumentSnapshot document) {
      return new PostCard(PostModel.mapFrom(document.data()));
    }).toList());
  }
}
