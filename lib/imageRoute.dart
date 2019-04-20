import 'package:flutter/material.dart';

class ImageRoute extends StatelessWidget {
  
  final String instrument;
  final List<String> imageList;

  ImageRoute({Key key, @required this.imageList, this.instrument }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.instrument),
      ),
      body: Card(
        color: Colors.lightBlue,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(imageList[0])
          ],
        ),
      ),
    );
  }
}