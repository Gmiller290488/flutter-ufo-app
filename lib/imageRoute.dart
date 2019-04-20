import 'package:flutter/material.dart';

class ImageRoute extends StatelessWidget {

  final String imageName;

  ImageRoute({Key key, @required this.imageName }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.imageName),
      ),
      body: Card(
        color: Colors.lightBlue,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(imageName)
          ],
        ),
      ),
    );
  }
}