class Track {
  String? id;
  String? name;
  String? duration;

  Track({required this.id, required this.name, required this.duration});

  Track.fromJson(Map<String, dynamic> json){
    id = json['idTrack'];
    name = json['strAlbum'];
    duration = json['intDuration'];
  }
}