import 'package:Restaurant_social_mobile_app/data/model/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PostCard extends StatelessWidget {
  final PostModel data;

  PostCard(this.data);

  final TextStyle headStyle = TextStyle(
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
      fontSize: 20);

  final TextStyle style = TextStyle(color: Colors.black45, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Card(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(30),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Center(
                      child: Expanded(
                        child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: data.image,
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                  child: Text(
                    data.name,
                    style: headStyle,
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                child: Text(
                  data.desc,
                  textAlign: TextAlign.center,
                  style: style,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                child: Text(data.timeStamp.toDate().toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
