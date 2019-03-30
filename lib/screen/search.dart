import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prunusavium/screen/book.dart';
import 'package:prunusavium/store/favorite.dart';
import 'package:prunusavium/store/search.dart';

class SearchPage extends SearchDelegate {
  final FavoriteStore favStore;
  final SearchStore searchStore;

  SearchPage(this.searchStore, this.favStore);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      // icon: AnimatedIcon(
      //   icon: AnimatedIcons.menu_arrow,
      //   progress: transitionAnimation,
      // ),
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchStore.searchKeywords(query);

    return Observer(
      builder: (_) {
        if (!searchStore.hasResults) {
          return Container(
            child: LinearProgressIndicator(),
          );
        }

        if (searchStore.books.isEmpty) {
          return Center(
            child: Text('oops ... nothing found'),
          );
        }

        return ListView.builder(
            itemCount: searchStore.books.length,
            itemBuilder: (_, int index) {
              final book = searchStore.books[index];
              return Card(
                margin: EdgeInsets.all(5.0),
                elevation: 5.0,
                child: ListTile(
                  title: Text(book.title),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BookPage(book, favStore),
                      ),
                    );
                  },
                ),
              );
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchStore.loadHistory();

    return ListView.builder(
      itemCount: searchStore.history.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            Icon(Icons.book),
            FlatButton(
              child: SizedBox(
                // width: double.infinity,
                child: Text(
                  searchStore.history[index],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              onPressed: () {
                query = searchStore.history[index];
              },
            ),
          ],
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }
}
