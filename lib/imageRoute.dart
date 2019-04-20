import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ImageRoute extends StatelessWidget {

  final String instrument;
  final List<String> imageList;

  ImageRoute({Key key, @required this.imageList, this.instrument }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.instrument),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body:
          Container(
            color: Color.fromRGBO(58, 66, 86, 1.0),
            child:
            Swiper(
              itemBuilder: (BuildContext context,int index){
                return new Image.network(imageList[index], fit: BoxFit.fitWidth);
              },
              itemCount: imageList.length,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          ),
        );
  }
}