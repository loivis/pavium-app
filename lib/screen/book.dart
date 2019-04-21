import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pavium/model/book.dart';
import 'package:pavium/store/favorite.dart';

class BookPage extends StatefulWidget {
  final Book book;
  final FavoriteStore favStore;

  const BookPage(this.book, this.favStore);

  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  void initState() {
    super.initState();
    widget.favStore.setFavoriteStatus(widget.book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('简介'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Observer(
            builder: (_) {
              if (widget.favStore.isFavorite) {
                return Icon(Icons.favorite, color: Colors.red);
              }
              return Icon(Icons.favorite_border);
            },
          ),
          onPressed: () {
            widget.favStore.flipFavorite(widget.book);
          },
        ),
        IconButton(
          icon: Icon(Icons.cloud_download),
          onPressed: () {},
        ),
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.book.image,
                height: 100.0,
                placeholder: (ctx, str) => CircularProgressIndicator(),
                errorWidget: (ctx, str, obj) => Icon(Icons.error),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text(widget.book.title,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text([
                        widget.book.author,
                        widget.book.site,
                      ].join(' | '))),
                  Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text("widget.book.update")),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('收藏'),
                  onPressed: () {
                    widget.favStore.flipFavorite(widget.book);
                  },
                ),
                RaisedButton(
                  child: Text('阅读'),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text("widget.book.intro"),
          ),
        ],
      ),
    );
  }
}
