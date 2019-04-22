import 'package:mobx/mobx.dart';
import 'package:pavium/env.dart';
import 'package:pavium/model/book.dart';
import 'package:dio/dio.dart';
import 'package:pavium/util/prefs.dart';

part 'search.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore implements Store {
  final Env env;

  String _lastQuery;
  bool _searching = false;

  _SearchStore(this.env);

  @observable
  List<String> history = [];

  // @observable
  // ObservableList<Book> books = ObservableList<Book>();
  List<Book> books = [];

  @observable
  ObservableFuture<dynamic> searchKeywordsFuture = empty;

  static ObservableFuture<dynamic> empty = ObservableFuture.value([]);

  // @computed
  // bool get hasResults => books.isNotEmpty;

  @computed
  bool get hasResults =>
      searchKeywordsFuture != empty &&
      searchKeywordsFuture.status == FutureStatus.fulfilled;

  @action
  void loadHistory() {
    history = Prefs.getStringList("history") ?? [];
  }

  @action
  void abort() {
    _searching = false;
  }

  Future searchKeywords(query) async {
    if (query == "") {
      print("empty search query");
      return;
    }
    if (_lastQuery == query) {
      print("the same query as last");
      return;
    }
    if (_searching) {
      print("skip duplicated search call");
      return;
    }

    _searching = true;
    print('search on: $query');

    books = [];
    try {
      final future = Dio().get("${env.endpoint}/search?keywords=$query");
      searchKeywordsFuture = ObservableFuture(future);
      final response = await future;
      for (var item in response.data) {
        books.add(Book.fromJson(item));
      }
    } catch (e) {
      _searching = false;
      print(e);
    }

    _lastQuery = query;
    _searching = false;
    updateHistory(query);

    print('number of books returned: ${books.length}');
  }

  void updateHistory(query) {
    if (history.indexOf(query) > 0) {
      history.remove(query);
    }
    history.insert(0, query);

    // deduplicate
    history = history.toSet().toList();

    Prefs.setStringList("history", history);
  }
}
