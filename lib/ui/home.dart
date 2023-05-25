import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
              child: ListTile(
                title: Text(widget.album.name!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.album.artist!),
                    Text(widget.album.yearReleased!),
                  ],
                ),
                leading: Image(image: NetworkImage(widget.album.urlPoster!)),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            );
  }
}
