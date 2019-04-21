import 'package:flutter/material.dart';
import 'package:pavium/model/favorite.dart';
import 'package:pavium/store/book.dart';
import 'package:pavium/store/favorite.dart';
import 'package:pavium/util/paginator.dart';
import 'package:pavium/util/prefs.dart';

class TextPage extends StatefulWidget {
  final Favorite favorite;
  final FavoriteStore favStore;
  final BookStore bookStore;

  const TextPage(this.favorite, this.favStore, this.bookStore);

  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  String text;

  double fontSize = Prefs.getInt('readFontSize') ?? 20;
  int subpage = Prefs.getInt('readSubpage') ?? 0;
  List<String> _pages;
  bool _showMenu = false;

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
          body: Stack(
            children: buildStackChildren(),
          ),
        );
      },
    );
  }

  List<Widget> buildStackChildren() {
    var children = <Widget>[
      buildTextLayer(),
      buildTouchLayer(),
    ];

    if (_showMenu) {
      children.add(buildMenuLayer());
    }

    return children;
  }

  Widget buildTextLayer() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          _pages = Paginator.getPages(
              text, constraints.maxHeight - 20, constraints.maxWidth, fontSize);
          print(_pages.length);

          if (subpage >= _pages.length) {
            subpage = _pages.length - 1;
          }

          return Text(_pages[subpage], style: TextStyle(fontSize: fontSize));
        },
      ),
    );
  }

  buildTouchLayer() {
    var size = MediaQuery.of(context).size;
    return Opacity(
      opacity: 0.3,
      child: Table(
        children: () {
          List<TableRow> rows = [];
          Map<Color, dynamic> onTap = {
            Colors.red: () {
              setState(() {
                _showMenu = !_showMenu;
              });
              print('middle');
            },
            Colors.green: () {
              print('back');
              setState(() {
                if (subpage > 0) {
                  subpage--;
                }
                print(subpage);
              });
            },
            Colors.indigo: () {
              print('forward');
              setState(() {
                if (subpage < _pages.length - 1) {
                  subpage++;
                }
                print(subpage);
              });
            },
          };
          for (var i = 0; i < 3; i++) {
            var row = TableRow(
              children: () {
                List<Widget> cells = [];
                for (var j = 0; j < 3; j++) {
                  Color color;
                  if (i == j && i == 1) {
                    color = Colors.red;
                  } else if (j < 2 && i + j <= 2) {
                    color = Colors.green;
                  } else {
                    color = Colors.indigo;
                  }

                  Widget cell = GestureDetector(
                    child: Container(
                      width: size.width / 3,
                      height: size.height / 3,
                      decoration: BoxDecoration(color: color),
                    ),
                    onTap: onTap[color],
                  );
                  cells.add(cell);
                }
                return cells;
              }(),
            );
            rows.add(row);
          }
          return rows;
        }(),
      ),
    );
  }

  buildMenuLayer() {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Positioned(
          height: size.height,
          width: size.width,
          child: GestureDetector(onTap: () {
            setState(() {
              _showMenu = !_showMenu;
            });
          }),
        ),
        Positioned(
            top: size.height - 100.0,
            width: size.width,
            child: BottomAppBar(
                color: Theme.of(context).backgroundColor,
                child: Row(children: <Widget>[
                  FlatButton(onPressed: () {}, child: null)
                ]))),
        Positioned(
          top: size.height - 75.0,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '换源',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              Text(
                '字体',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              Text(
                '亮度',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            ],
          ),
        ),
        Positioned(
          top: size.height * 2 / 3,
          left: size.width / 2 - 60.0,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, size: 50.0),
                onPressed: () {
                  Navigator.of(context).pop();
                  // model.toggleMenuBar();
                },
              ),
              IconButton(
                icon: Icon(Icons.format_list_bulleted, size: 50.0),
                onPressed: () {
                  print('list chapters');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
