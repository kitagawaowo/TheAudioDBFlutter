import 'package:flutter/material.dart';
import 'package:music_flutter/data/http_helper.dart';
import 'package:music_flutter/data/track.dart';

import 'album.dart';

class TrackList extends StatefulWidget {
  const TrackList({super.key, required this.album});
  final Album album;

  @override
  State<TrackList> createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  HttpHelper? httpHelper;
  List<Track>? tracks;

  Future initialize() async {
    tracks = List.empty();
    tracks = await httpHelper?.getTracksByAlbumId(widget.album.id!);
  }
  @override
  void initState(){
    httpHelper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}