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

  onButtonClicked(title) {
    setState(() {
      print("Button clicked");
      print(title);
    });
  }

  Widget _buildItem(Song song) {

    List<String> _tenor = song.tenorMusic;
    List<String> _second = song.secondsMusic;
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ExpansionTile(
          title: Text(song.title, style: TextStyle(fontSize: 24.0),textAlign: TextAlign.start),
          children: [
            Column(
                children: <Widget>[
                  Text(song.artist),

                  MaterialButton(
                    color: Colors.green,
                    onPressed: () async {
                      if (await canLaunch(song.url)) {
                        launch(song.url);
                      };
                    },
                    child: Text("Open in Youtube"),
                  ),
                  Column(
                    children: _tenor.map((tenorMusic) => MusicButton(title: tenorMusic)).toList(),
//                    children: _tenor.map((tenorMusic) => Text(tenorMusic)).toList(),toList
                  ),
                  Column(
                    children: _second.map((secondMusic) => Text(secondMusic)).toList(),
                  ),
                ]
            ),
          ],
//            }
        ),
      ),
    );
  }
}

class MusicButton extends StatelessWidget {

  final String title;
  final Function(String) onPressed;

  const MusicButton({ this.title, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child:
          Text(this.title),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute()),
        );
      }
    );
  }
}


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("second route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("go back!"),
        ),
      ),
    );
  }
}

