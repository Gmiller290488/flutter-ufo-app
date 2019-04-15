

class Song {

  final String title;
  final String url;
  final String artist;
  final List<String> tenorMusic;
  final List<String> secondsMusic;


  const Song(
      {
        this.title,
        this.url,
        this.artist,
        this.tenorMusic,
        this.secondsMusic});
}

final songs = [
  new Song(
      title:"Hulk",
      url: "https://www.youtube.com/watch?v=zHb1vXpffhI",
      artist: "Blaxx",
      tenorMusic: ["hulk-tenor1.jpg", "hulk-tenor2.jpg"],
      secondsMusic: ["hulk-seconds"]

  ),
  new Song(
      title: "Inside The Festival",
      url: "https://www.youtube.com/watch?v=NnOVm4E9VaU",
      artist: "Ultimate Rejects",
    tenorMusic: ["ITF-tenor.png"],
    secondsMusic: []
  )
];