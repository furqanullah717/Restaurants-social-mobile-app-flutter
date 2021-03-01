import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String name;
  String uuid;
  String image;
  String desc;
  Timestamp timeStamp;
  String userName;

  PostModel();

  PostModel.mapFrom(Map data) {
    this.name = data["name"];
    this.uuid = data["userid"];
    this.userName = data["userName"];
    this.image = data["image"];
    this.desc = data["description"];
    this.timeStamp = data["timestamp"];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'userid': uuid,
        'userName': userName,
        'image': image,
        'description': desc,
        'timestamp': timeStamp
      };
}
