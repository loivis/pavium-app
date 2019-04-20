import 'package:flutter/material.dart';
import 'package:prunusavium/model/favorite.dart';
import 'package:prunusavium/store/book.dart';
import 'package:prunusavium/store/favorite.dart';

class TextPage extends StatefulWidget {
  final Favorite favorite;
  final FavoriteStore favStore;
  final BookStore bookStore;

  const TextPage(this.favorite, this.favStore, this.bookStore);

  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  String text;

  Future asyncInit() async {
    text = await widget.favStore.loadFavorite(widget.favorite);
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: asyncInit(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: Text(text.substring(0, 33)),
          ),
        );
      },
    );
  }
}
