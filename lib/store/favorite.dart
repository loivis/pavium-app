import 'package:mobx/mobx.dart';
import 'package:prunusavium/model/book.dart';
import 'package:prunusavium/model/favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorite.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore implements Store {
  final SharedPreferences prefs;

  _FavoriteStore(this.prefs);

  @observable
  ObservableList<Favorite> favorites = ObservableList<Favorite>();

  @observable
  bool isFavorite = false;

  @observable
  bool loaded = false;

  @observable
  ObservableFuture<List<Favorite>> fetchFavsFuture = ObservableFuture.value([]);

  @computed
  bool get updated =>
      loaded == true &&
      fetchFavsFuture != null &&
      fetchFavsFuture.status == FutureStatus.fulfilled;

  @action
  checkFavritesUpdate() {
    print("check favorite update");
    favorites.add(Favorite(
        "author2",
        "id2",
        "https://lh3.googleusercontent.com/H_6PL2Br4qdh2oLTF4QeqwgWWiPvOpre044cCFbwrA5oepf1uaFsvXOQ1HFr5uK4OYLh=s360-rw",
        "site2",
        "title2",
        "update2"));
  }

  @action
  void loadFavorites() {
    print("load favorites");

    favorites.add(Favorite(
        "author",
        "id",
        "https://lh3.googleusercontent.com/H_6PL2Br4qdh2oLTF4QeqwgWWiPvOpre044cCFbwrA5oepf1uaFsvXOQ1HFr5uK4OYLh=s360-rw",
        "site",
        "title",
        "update"));
    loaded = true;
  }

  @action
  void setFavoriteStatus(Book book) {
    isFavorite = false;
    for (var fav in favorites) {
      if (fav.key == book.key) {
        isFavorite = true;
      }
    }
  }

  @action
  void flipFavorite(Book book) {
    Favorite newf =
        Favorite(book.author, book.id, book.image, book.site, book.title, "");
    if (isFavorite) {
      for (var fav in favorites) {
        if (fav.key == newf.key) {
          favorites.remove(fav);
        }
      }
    } else {
      favorites.add(newf);
    }
    isFavorite = !isFavorite;
  }
}
