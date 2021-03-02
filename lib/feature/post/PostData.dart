import 'package:Restaurant_social_mobile_app/data/model/PostModel.dart';
import 'package:Restaurant_social_mobile_app/feature/post/PostCard.dart';
import 'package:Restaurant_social_mobile_app/feature/post/addPost/AddPost.dart';
import 'package:Restaurant_social_mobile_app/repository/PostRepoository.dart';
import 'package:Restaurant_social_mobile_app/utils/UiUtils.dart';
import 'package:Restaurant_social_mobile_app/utils/Utils.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostData extends StatefulWidget {
  final List<String> ids;
  final PostRepository postRepository;

  PostData(this.ids, this.postRepository);

  @override
  _PostDataState createState() => _PostDataState(ids, postRepository);
}

class _PostDataState extends State<PostData> {
  final List<String> ids;
  final PostRepository postRepository;

  _PostDataState(this.ids, this.postRepository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: postRepository.getListOfFriendsPost(ids),
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
          final cameras = await availableCameras();
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
    if (Utils.isNullOrEmpty(snapshot)) {
      return UiUtils.getErrorWidget("No data found");
    }
    return ListView(
        children: snapshot.data.docs.map((DocumentSnapshot document) {
      return new PostCard(PostModel.mapFrom(document.data()));
    }).toList());
  }
}
