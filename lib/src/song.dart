class Song {

  final String title;
  final String url;
  final String artist;

  const Song(
  {
    this.title,
  this.url,
  this.artist});
  }

  final songs = [
    new Song(
      title:"Hulk",
      url: "https://www.youtube.com/watch?v=zHb1vXpffhI",
      artist: "Blaxx"
    ),
    new Song(
      title: "Inside The Festival",
      url: "https://www.youtube.com/watch?v=NnOVm4E9VaU",
      artist: "Ultimate Rejects"
    )
  ];