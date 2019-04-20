class Song {
  int id;
  String songName;
  String artist;
  String youtubeUrl;
  List<MusicNote> notes;


  Song({ this.id, this.songName, this.artist, this.youtubeUrl, this.notes });

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
        id: parsedJson['id'],
        songName: parsedJson['Name'],
        artist: parsedJson['Artist'],
        youtubeUrl: parsedJson['youtubeUrl'],
        notes: parseNotes(parsedJson['musicNotes']));
  }


  static List<MusicNote> parseNotes(notesJson) {
    var list = notesJson as List;
    List<MusicNote> notesList = list.map((data) => MusicNote.fromJson(data)).toList();

    return notesList;
  }
}

class MusicNote {
  final int id;
  final String name;
  final List<String> imgUrl;

  MusicNote({ this.id, this.name, this.imgUrl });

  factory MusicNote.fromJson(Map<String, dynamic> json) {
    return MusicNote(
        id: json['id'] as int,
        name: json['name'],
        imgUrl: parseImageUrls(json['imgUrl'])
        );
  }

  static List<String> parseImageUrls(imageUrlsJson) {
    List<String> imageUrlsList = List<String>.from(imageUrlsJson);
    return imageUrlsList;
  }
}