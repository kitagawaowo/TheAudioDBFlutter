import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_flutter/data/db_helper.dart';

import '../data/album.dart';
import 'album_list.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  DbHelper? dbHelper;
  List<Album>? albums;

  loadAlbums() async {
    await dbHelper?.openDb();
    final result = await dbHelper?.fetchAll();
    setState(() {
      albums = result;
    });

    //dbHelper
  }

  @override
  void initState() {
    albums = List.empty();
    dbHelper = DbHelper();
    loadAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: albums?.length,
            itemBuilder: (context, index) {
              return AlbumItem(album: albums![index]);
            }));
  }
}
