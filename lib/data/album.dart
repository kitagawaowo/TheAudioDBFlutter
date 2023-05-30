class Album {
  String id;
  String name;
  String artist;
  String yearReleased;
  String urlPoster;

  Album(
      {required this.id,
      required this.name,
      required this.artist,
      required this.yearReleased,
      required this.urlPoster});

  Album.fromJson(Map<String, dynamic> json)
      : this(
            id: json['idAlbum'],
            name: json['strAlbum'],
            artist: json['strArtist'],
            yearReleased: json['intYearReleased'],
            urlPoster: json['strAlbumThumb']);

  Album.fromMap(Map<String, dynamic> json)
      : this(
            id: json['id'],
            name: json['name'],
            artist: json['artist'],
            yearReleased: json['year'],
            urlPoster: json['poster']);

  /*Album.fromMap(Map<String, dynamic> map){

    id = map['id'];

    name = map['name'];

    artist = map['artist'];

    yearReleased = map['year'];

    urlPoster = map['poster'];

  }
  */

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'year': yearReleased,
      'poster': urlPoster
    };
  }
}
