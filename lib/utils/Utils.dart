import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utils {
 static bool isNullOrEmpty(AsyncSnapshot<QuerySnapshot> snapshot){
 return  ( snapshot.data == null ||
        snapshot.data.docs == null ||
        snapshot.data.docs.length == 0);
  }
}