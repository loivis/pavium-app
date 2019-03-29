import 'package:mobx/mobx.dart';
import 'package:prunusavium/env.dart';
import 'package:prunusavium/model/book.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore implements Store {
  final Env env;
  final SharedPreferences prefs;

  String _lastQuery;

  _SearchStore(this.env, this.prefs);

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
    history = prefs.getStringList("history") ?? [];
  }

  @action
  Future searchKeywords(query) async {
    if (query == "" || _lastQuery == query) {
      return;
    }

    print('search on: $query');

    books = [];

    var index = history.indexOf(query);
    if (index > 0) {
      history.remove(query);
    }
    history.insert(0, query);
    prefs.setStringList("history", history);

    try {
      final future = Dio().get("${env.endpoint}/v1/search?keywords=$query");
      searchKeywordsFuture = ObservableFuture(future);
      final response = await future;
      for (var item in response.data) {
        books.add(Book.fromJson(item));
      }
    } catch (e) {
      print(e);
    }

    _lastQuery = query;

    print('number of books returned: ${books.length}');
  }
}
