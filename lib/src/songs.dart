class Song {
  int id;
  String songName;
  String artist;
  String youtubeUrl;
  List<String> notes;


  Song({ this.id, this.songName, this.artist, this.youtubeUrl, this.notes });

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
        id: parsedJson['id'],
        songName: parsedJson['Name'],
        artist: parsedJson['Artist'],
        youtubeUrl: parsedJson['youtubeUrl'],
        notes: parseNotes(parsedJson['musicNotes']));
  }

  static List<String> parseNotes(notesJson) {
    List<String> notesList = new List<String>.from(notesJson);
    return notesList;
  }
}
