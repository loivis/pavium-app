import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:prunusavium/model/favorite.dart';
import 'package:prunusavium/screen/text.dart';
import 'package:prunusavium/store/favorite.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritePage extends StatefulWidget {
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoriteStore favStore = FavoriteStore();

  void initState() {
    super.initState();
    this.favStore.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavoriteListView(favStore),
      floatingActionButton: FAB(favStore),
    );
  }
}

class FavoriteListView extends StatelessWidget {
  final FavoriteStore store;

  const FavoriteListView(this.store);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) {
          if (!this.store.loaded) {
            return Center(
              child: Text("loading favorites"),
            );
          }

          if (this.store.favorites.isEmpty) {
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
      List<Favorite> favs = this.store.favorites;

      if (idx.isOdd) {
        return Divider(color: Theme.of(context).backgroundColor);
      }

      Favorite fav = favs[idx ~/ 2];

      CachedNetworkImage leading = CachedNetworkImage(
        imageUrl: fav.image,
        height: 75.0,
        // placeholder: (ctx, str) => CircularProgressIndicator(),
        // errorWidget: (ctx, str, obj) => Icon(Icons.error),
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => TextPage(),
            ),
          );
        },
        onLongPress: () {},
      );
    };

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      itemCount: this.store.favorites.length * 2,
      itemBuilder: __itemBuilder,
    );
  }
}

class FAB extends StatelessWidget {
  final FavoriteStore store;

  const FAB(this.store);

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => FloatingActionButton(
              child: store.fetchFavsFuture.status == FutureStatus.pending
                  ? const LinearProgressIndicator()
                  : Icon(Icons.refresh),
              onPressed: () {
                store.checkFavritesUpdate();
              },
              mini: true,
            ),
      );
}
