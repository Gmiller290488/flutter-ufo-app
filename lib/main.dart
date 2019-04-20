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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0)
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
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: Container(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
          songs == null ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : ListView.builder(
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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color.fromRGBO(86, 93, 108, 1.0),
      ),
      child:
      ExpansionTile(
        title:
        Container(
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
          Column(
            children: _musicNotes.map((notes) => MusicButton(musicNote: notes)).toList(),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
            color: Color.fromRGBO(58, 66, 86, 0.5)
            ),
            child:
                  ListTile(
                    title: Text(
                        "Watch on YouTube", textAlign: TextAlign.center ,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    onTap: () async {
                      if (await canLaunch(widget.song.youtubeUrl)) {
                        launch(widget.song.youtubeUrl);
                      };
                    },
                  ),

          ),
        ],
        backgroundColor: Colors.transparent,
        onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
      ),
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




