import 'dart:io';

import 'package:Restaurant_social_mobile_app/data/model/PostModel.dart';
import 'package:Restaurant_social_mobile_app/utils/UiUtils.dart';
import 'package:Restaurant_social_mobile_app/widget/CustomButton.dart';
import 'package:Restaurant_social_mobile_app/widget/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// ignore: must_be_immutable
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  BuildContext context;

  DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(title: Text('Display the Picture')),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Image.file(File(imagePath)),
                CustomTextField("Name", TextInputType.visiblePassword, false,
                    nameController, (text) {
                  if ((text.toString().isEmpty)) {
                    return "Restaurant Name cannot be empty";
                  }
                  return null;
                }),
                CustomTextField("Description", TextInputType.visiblePassword,
                    false, descController, (text) {
                  if ((text.toString().isEmpty)) {
                    return "Description Name cannot be empty";
                  }
                  return null;
                }),
                CustomButton("Submit", onButtonClicked)
              ],
            ),
          ),
        ));
  }

  Future<String> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      var taskSnapshot = await firebase_storage.FirebaseStorage.instance
          .ref('posts/' + getFileName())
          .putFile(file);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return "";
    }
  }

  getFileName() {
    return "image_" + DateTime.now().millisecond.toString() + ".jpg";
  }

  onButtonClicked() {
    UiUtils.showLoaderDialog(
        context, "Please wait while we data being updated ..");
    uploadFile(imagePath).then((value) => {pushToServer(value)});
  }

  pushToServer(String value) {
    PostModel model = new PostModel();
    User user = FirebaseAuth.instance.currentUser;
    model.uuid = user.uid;
    model.userName = user.displayName;
    model.timeStamp = Timestamp.now();
    model.desc = descController.text;
    model.name = nameController.text;
    model.image = value;
    FirebaseFirestore.instance
        .collection("posts")
        .add(model.toJson())
        .then((value) => {hideLoader()});
  }

  hideLoader() {
    UiUtils.hideLoader(context);
    Navigator.pop(context);
  }
}
