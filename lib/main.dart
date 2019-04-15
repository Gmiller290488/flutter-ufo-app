import 'package:flutter/material.dart';
import 'src/songs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  build(context) {
    return MaterialApp(
      title: 'UFO Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;

  @override
  createState() => _MyHomePageState();
}

class API {
  static Future getSongs() {
    var url = "https://api.myjson.com/bins/18cs30";
    return http.get(url);
  }
}

class _MyHomePageState extends State {

//  List<Song> _songs = songs;
  var songs = new List<Songs>();

  _getSongs() {
    API.getSongs().then((response) {

      setState(() {
        Iterable list = json.decode(response.body);
        songs = list.map((model) => Songs.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getSongs();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("UFO"),
        ),
        body: ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) {
//            return ExpansionTile(title: Text(songs[index].songName));
          return MusicButton(uri: songs[index].tenor1.toString());
          },
        ));
    }
  }

//  onButtonClicked(title) {
//    setState(() {
//      print("Button clicked");
//      print(title);
//    });
//  }
//
//  Widget _buildItem(Song song) {
//
//    List<String> _tenor = song.tenorMusic;
//    List<String> _second = song.secondsMusic;
//    return new Padding(
//      padding: const EdgeInsets.all(16.0),
//      child: Center(
//        child: ExpansionTile(
//          title: Text(song.title, style: TextStyle(fontSize: 24.0),textAlign: TextAlign.start),
//          children: [
//            Column(
//                children: <Widget>[
//                  Text(song.artist, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//
//                  MaterialButton(
//                    color: Colors.green,
//                    onPressed: () async {
//                      if (await canLaunch(song.url)) {
//                        launch(song.url);
//                      };
//                    },
//                    child: Text("Open in Youtube"),
//                  ),
//                  Column(
//                    children: _tenor.map((tenorMusic) => MusicButton(title: tenorMusic)).toList(),
////                    children: _tenor.map((tenorMusic) => Text(tenorMusic)).toList(),
//                  ),
//                  Column(
//                    children: _second.map((secondMusic) =>  MusicButton(title: secondMusic)).toList(),
//                  ),
//                ]
//            ),
//          ],
////            }
//        ),
//      ),
//    );
//  }
//}
//
class MusicButton extends StatelessWidget {

  final String uri;
  final Function(String) onPressed;

  const MusicButton({ this.uri, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.grey,
      child:
          Text(this.uri),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute(imageName: this.uri)),
        );
      }
    );
  }
}


class SecondRoute extends StatelessWidget {

  final String imageName;

  SecondRoute({Key key, @required this.imageName }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.imageName),
      ),
//        body: Image.asset('assets/images/${imageName}'),
      body: Image.network(imageName)
      );
  }
}
