import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prunusavium/model/favorite.dart';
import 'package:prunusavium/screen/text.dart';
import 'package:prunusavium/store/book.dart';
import 'package:prunusavium/store/favorite.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritePage extends StatefulWidget {
  final FavoriteStore favStore;
  final BookStore bookStore;

  FavoritePage(this.favStore, this.bookStore);

  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavoriteListView(widget.favStore, widget.bookStore),
    );
  }
}

class FavoriteListView extends StatelessWidget {
  final FavoriteStore favStore;
  final BookStore bookStore;

  const FavoriteListView(this.favStore, this.bookStore);

  @override
  Widget build(BuildContext context) {
    if (!this.favStore.loaded) {
      favStore.loadFavorites();
    }

    return Container(
      child: Observer(
        builder: (_) {
          if (!this.favStore.loaded) {
            return Center(
              child: Text("loading favorites"),
            );
          }

          if (this.favStore.favorites.isEmpty) {
            return Center(
              child: Text("no favorites yet"),
            );
          }

          return _buildFavList();
        },
      ),
    );
  }

  Widget _buildFavList() {
    var __itemBuilder = (BuildContext context, int idx) {
      List<Favorite> favs = this.favStore.favorites;

      if (idx.isOdd) {
        return Divider(color: Theme.of(context).backgroundColor);
      }

      Favorite fav = favs[idx ~/ 2];

      CachedNetworkImage leading = CachedNetworkImage(
        imageUrl: fav.image,
        height: 75.0,
        placeholder: (ctx, str) => CircularProgressIndicator(),
        errorWidget: (ctx, str, obj) => Icon(Icons.error),
      );

      Column subtitle = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${fav.author} | ${fav.site}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 200,
                child: Text(
                  "latest chapter name",
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.bookmark, color: Colors.red, size: 15.0)
            ],
          ),
        ],
      );

      return ListTile(
        leading: leading,
        title: Text(fav.title),
        subtitle: subtitle,
        onTap: () {
          print(fav.toJson());
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  TextPage(fav, this.favStore, this.bookStore),
            ),
          );
        },
        onLongPress: () {},
      );
    };

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: this.favStore.favorites.length * 2,
      itemBuilder: __itemBuilder,
    );
  }
}
