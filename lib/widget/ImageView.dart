import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageView extends StatelessWidget {
  final String url;
  ImageView(this.url);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(200)),
      height: 50,
      width: 50,
      child: Stack(
        children: <Widget>[
          Center(
            child: Expanded(
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: url,
                  fit: BoxFit.fitWidth),
            ),
          ),
        ],
      ),
    );
  }
}
