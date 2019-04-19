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

//  static List<Images> parseImages(imagesJson) {
//    var list = imagesJson['images'] as List;
//    List<Images> imagesList =
//    list.map((data) => Images.fromJson(data)).toList();
//    return imagesList;


  static List<MusicNote> parseNotes(notesJson) {
    print(notesJson);
    var list = notesJson as List;
    print("fucc1");
    print(list);
    List<MusicNote> notesList = list.map((data) => MusicNote.fromJson(data)).toList();
    print(notesList);

    return notesList;
  }
}

class MusicNote {
  final int id;
  final String name;
  final String imgUrl;

  MusicNote({ this.id, this.name, this.imgUrl });

  factory MusicNote.fromJson(Map<String, dynamic> json) {
    return MusicNote(
        id: json['id'] as int,
        name: json['name'],
        imgUrl: json['imgUrl']
        );
  }
}