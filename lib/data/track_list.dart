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
    setState(() {
      tracks = tracks;
    });
  }
  @override
  void initState(){
    httpHelper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: ListView.builder(
        itemCount: tracks?.length,
        itemBuilder: (context, index){
          return TrackItem(track: tracks![index]);
        }),
        */
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(widget.album.name!),
              pinned: true,
              snap: false,
              floating: true,
              //flexibleSpace: Image(image: NetworkImage(widget.album.urlPoster!)),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.album.artist!),
                background: Image(image: NetworkImage(widget.album.urlPoster!)),
              ),
              expandedHeight: 200,
            ),
            SliverList.builder(
              itemCount: tracks?.length,
              itemBuilder: (context, index){
                return TrackItem(track: tracks![index]);
              }
            )
          ]
        )
    );
  }
}

class TrackItem extends StatefulWidget {
  const TrackItem({super.key, required this.track});
  final Track track;

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.track.name!),
        subtitle: Text(widget.track.duration!),
      )
    );
  }
}