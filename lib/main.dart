import 'package:flutter/material.dart';
import 'src/songs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'imageRoute.dart';

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

  @override
  createState() => _MyHomePageState();
}

class API {
  static Future getSongs() {
    var url = "https://api.myjson.com/bins/15rmuc";
    return http.get(url);
  }
}



class _MyHomePageState extends State {

  List<Song> songs;

  _getSongs() {
    API.getSongs().then((response) {
      setState(() {
        songs = parseSongs(response.body);

      });

    });
  }

  static List<Song> parseSongs(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Song>((json) => Song.fromJson(json)).toList();

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
        title: Text("UFO"),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.lightBlue[900],
                Colors.lightBlue[700],
                Colors.lightBlue[500],
                Colors.lightBlue[200],
              ],
            ),
          ),
          child:
          songs == null ? Center(child: CircularProgressIndicator()) : ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return _buildItem(songs[index]);
            },
          )
      ),
    );
  }
}


Widget _buildItem(Song song) {

  return new Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
        child: CustomExpansionTile(song: song)
    ),
  );
}


class CustomExpansionTile extends StatefulWidget {

  final Song song;
  const CustomExpansionTile({Key key, this.song}): super(key: key);

  @override
  State createState() => CustomExpansionTileState();
}

class CustomExpansionTileState extends State<CustomExpansionTile> {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    List<MusicNote> _musicNotes = widget.song.notes;

    return ExpansionTile(
      title: Container(
        child:
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${widget.song.songName}\n${widget.song.artist}",
            style: TextStyle(
                fontSize: 24.0, fontWeight: isExpanded ? FontWeight.bold : FontWeight.normal, color: Colors.amber
            ),
          ),
        ),
        // Change header (which is a Container widget in this case) background colour here.
        color: Colors.transparent,
      ),
      leading: Icon(
        Icons.music_note,
        color: Colors.amber,
        size: 36.0,
      ),
      trailing: isExpanded ? Icon(
          Icons.arrow_drop_up,
          color: Colors.amber) :
      Icon(
        Icons.arrow_drop_down,
        color: Colors.amber,
      ),
      children:
      <Widget>[
        MaterialButton(
          minWidth: 100,
          color: Colors.red,
          splashColor: Colors.orange,
          onPressed: () async {
            if (await canLaunch(widget.song.youtubeUrl)) {
              launch(widget.song.youtubeUrl);
            };
          },
          child: Text("Youtube"),
        ),
        Column(
          children: _musicNotes.map((notes) => MusicButton(musicNote: notes)).toList(),
        ),
      ],
      backgroundColor: Colors.transparent,
      onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
    );
  }
}

class MusicButton extends ListTile {

  final MusicNote musicNote;
  final Function(String) onPressed;

  const MusicButton({ this.musicNote, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child:
          ListTile(
            title: Text(
                musicNote.name.toString(), style: TextStyle(color: Colors.amber, fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.amber),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    ImageRoute(imageList: musicNote.imgUrl, instrument: musicNote.name)),
              );
            }
          ),
    ),
      ],
    );
  }
}




