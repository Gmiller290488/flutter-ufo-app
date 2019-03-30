import 'package:flutter/material.dart';
import 'src/song.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UFO Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Song> _songs = songs;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        children: _songs.map(_buildItem).toList(),
      ),
    );
  }

  Widget _buildItem(Song song) {
    return new Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
            title: Text(song.title, style: TextStyle(fontSize: 24.0)),
            subtitle: Text(song.artist),
            onTap: () async {

              if (await canLaunch(song.url)) {

                launch(song.url);
              };
            }
        )
    );
  }
}
