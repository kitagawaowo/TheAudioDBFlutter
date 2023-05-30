import 'dart:convert';
import 'dart:io';
import 'album.dart';

import 'package:http/http.dart' as http;

import 'track.dart';

class HttpHelper {
  final String urlBase =
      'https://theaudiodb.com/api/v1/json/523532/mostloved.php?format=album';

  final String urlBaseTrack =
      'https://theaudiodb.com/api/v1/json/523532/track.php?m=';

  Future<List<Album>?> getAlbums() async {
    http.Response response = await http.get(Uri.parse(urlBase));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final List albumsMap = jsonResponse['loved'];
      final List<Album> albums =
          albumsMap.map((map) => Album.fromJson(map)).toList();
      return albums;
    } else {
      return null;
    }
  }

  Future<List<Track>?> getTracksByAlbumId(String albumId) async {
    http.Response response = await http.get(Uri.parse(urlBaseTrack + albumId));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final List tracksMap = jsonResponse['track'];
      final List<Track> tracks =
          tracksMap.map((e) => Track.fromJson(e)).toList();
      return tracks;
    } else {
      return null;
    }
  }
}
