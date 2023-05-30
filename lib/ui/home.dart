import 'package:flutter/material.dart';
import 'package:music_flutter/data/db_helper.dart';
import 'package:music_flutter/ui/track_list.dart';

import '../data/album.dart';
import '../data/http_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Album>? albums;
  HttpHelper? httpHelper;

  Future initialize() async {
    albums = List.empty();
    albums = await httpHelper?.getAlbums();
    setState(() {
      albums = albums;
    });
  }

  @override
  void initState() {
    httpHelper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppSuperZound'),
      ),
      body: ListView.builder(
          itemCount: albums?.length,
          itemBuilder: (context, index) {
            return AlbumItem(album: albums![index]);
          }),
    );
  }
}

class AlbumItem extends StatefulWidget {
  const AlbumItem({super.key, required this.album});
  final Album album;

  @override
  State<AlbumItem> createState() => _AlbumItemState();
}

class _AlbumItemState extends State<AlbumItem> {
  bool isFavorite = false;
  DbHelper? dbHelper;

  @override
  void initState() {
    dbHelper = DbHelper();
    isFavoriteAlbum();
    super.initState();
  }

  isFavoriteAlbum() async {
    await dbHelper?.openDb();
    final result = await dbHelper?.isFavorite(widget.album);
    setState(() {
      isFavorite = result!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.album.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.album.artist),
            Text(widget.album.yearReleased),
          ],
        ),
        leading: Hero(
            tag: widget.album.id,
            child: Image(image: NetworkImage(widget.album.urlPoster))),
        trailing: IconButton(
          onPressed: () {
            isFavorite
                ? dbHelper?.delete(widget.album)
                : dbHelper?.insert(widget.album);
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          icon: Icon(
            Icons.favorite,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackList(
                album: widget.album,
              ),
            ),
          );
        },
      ),
    );
  }
}
