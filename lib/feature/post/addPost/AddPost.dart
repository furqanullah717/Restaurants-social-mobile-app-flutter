import 'dart:async';
import 'dart:io';
import 'package:Restaurant_social_mobile_app/data/model/PostModel.dart';
import 'package:Restaurant_social_mobile_app/utils/UiUtils.dart';
import 'package:Restaurant_social_mobile_app/widget/CustomButton.dart';
import 'package:Restaurant_social_mobile_app/widget/CustomTextField.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image?.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
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
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
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
      // e.g, e.code == 'canceled'
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
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
