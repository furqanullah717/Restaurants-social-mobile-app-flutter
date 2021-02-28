import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {

  String name;
  String uuid;
  String image;
  String desc;
  Timestamp timeStamp;

  PostModel();

  PostModel.mapFrom(Map data) {
    this.name = data["name"];
    this.uuid = data["userid"];
    this.image = data["image"];
    this.desc  = data["description"];
    this.timeStamp =  data["timestamp"];
  }

}