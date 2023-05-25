class Album {
  String? id;
  String? name;
  String? artist;
  String? yearReleased;
  String? urlPoster;

  Album(
      {required this.id,
      required this.name,
      required this.artist,
      required this.yearReleased,
      required this.urlPoster});

  Album.fromJson(Map<String, dynamic> json){
    id = json['idAlbum'];
    name = json['strAlbum'];
    artist = json['strArtist'];
    yearReleased = json['intYearReleased'];
    urlPoster = json['strAlbumThumb'];
  }   
}
