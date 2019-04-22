import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:pavium/model/book.dart';
import 'package:pavium/util/prefs.dart';

part 'book.g.dart';

class BookStore = _BookStore with _$BookStore;

abstract class _BookStore implements Store {
  @observable
  ObservableList<Book> books = ObservableList<Book>();

  @observable
  bool loaded = false;

  @observable
  ObservableFuture<List<Book>> fetchFavsFuture = ObservableFuture.value([]);

  @action
  void loadBook(Book book) {
    print("load book");

    var favStrings = Prefs.getStringList("books");
    // Prefs.remove('books');
    if (favStrings == null) {
      return;
    }

    for (var fs in favStrings) {
      Map<String, dynamic> favJson = json.decode(fs);
      Book fav = Book.fromJson(favJson);

      books.add(fav);
    }

    loaded = true;
  }

  @action
  void setBookStatus(Book book) {}
}
