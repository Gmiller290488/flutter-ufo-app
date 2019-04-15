class Songs {
  int id;
  String songName;
  String artist;
  String tenor1;
  String tenor2;

  Songs(int id, String songName, String artist, String tenor1, String tenor2) {
    this.id = id;
    this.songName = songName;
    this.artist = artist;
    this.tenor1 = tenor1;
    this.tenor2 = tenor2;
  }

  Songs.fromJson(Map json)
      : id = json['id'],
        songName = json['Name'],
        artist = json['Artist'],
        tenor1 = json["tenor1"],
        tenor2 = json["tenor2"];

  Map toJson() {
    return {'id': id, 'songName': songName, 'artist': artist, "tenor1": tenor1, "tenor2": tenor2};
  }
}