import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:pavium/env.dart';
import 'package:pavium/model/book.dart';
import 'package:pavium/model/chapter.dart';
import 'package:pavium/model/favorite.dart';
import 'package:pavium/util/prefs.dart';

part 'favorite.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore implements Store {
  final Env env;

  _FavoriteStore(this.env);

  @observable
  ObservableList<Favorite> favorites = ObservableList<Favorite>();

  @observable
  bool isFavorite = false;

  @observable
  bool loaded = false;

  @observable
  bool textLoaded = false;

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
    print(favorites.length);
  }

  @action
  void loadFavorites() {
    print("load favorites");
    loaded = false;

    var favStrings = Prefs.getStringList("favorites");
    if (favStrings == null) {
      loaded = true;
      return;
    }

    print("favStrings.length: ${favStrings.length}");
    for (var fs in favStrings) {
      Map<String, dynamic> favJson = json.decode(fs);
      Favorite fav = Favorite.fromJson(favJson);

      favorites.add(fav);
    }

    print("favorites.length: ${favorites.length}");

    loaded = true;
  }

  @action
  void setFavoriteStatus(Book book) {
    isFavorite = false;
    print("total favs: ${favorites.length}");
    for (var fav in favorites) {
      if (fav.key == book.key) {
        isFavorite = true;
      }
    }
  }

  @action
  void flipFavorite(Book book) {
    Favorite newf = Favorite(book.author, book.id, book.image, book.site,
        book.title, "", 0, book.site);

    if (isFavorite) {
      Favorite toRemove;
      for (var fav in favorites) {
        if (fav.key == newf.key) {
          toRemove = fav;
        }
      }
      favorites.remove(toRemove);
    } else {
      favorites.add(newf);
    }

    List<String> favStrings = [];
    for (var fav in favorites) {
      favStrings.add(json.encode(fav.toJson()));
    }

    print("favStrings: $favStrings");
    print("favStrings.length: ${favStrings.length}");

    Prefs.setStringList('favorites', favStrings);

    isFavorite = !isFavorite;
  }

  Future<String> loadFavorite(Favorite fav) async {
    List<Chapter> chapters = [];

    textLoaded = false;

    print(fav.toJson());

    await loadChapter(fav, chapters);

    String text = await loadText(fav, chapters);

    textLoaded = true;

    return text;
  }

  Future<String> loadText(Favorite fav, List<Chapter> chapters) async {
    if (fav.progress >= chapters.length && fav.progress > 0) {
      fav.progress = chapters.length - 1;
    }
    String text = Prefs.getString("${fav.key}-${fav.progress}");

    if (text == null) {
      print("no existing text found");
      print(
          "text link: ${env.endpoint}/text?site=${fav.source}&link=${chapters[fav.progress].link}");
      final response = await Dio().get(
          "${env.endpoint}/text?site=${fav.source}&link=${chapters[fav.progress].link}");
      print("${response.data}");
      text = response.data;
      Prefs.setString("${fav.key}-${fav.progress}", text);
    }

    print("load existing text");
    return text;
  }

  Future loadChapter(Favorite fav, List<Chapter> chapters) async {
    var chapterStrings = Prefs.getStringList(fav.key);
    if (chapterStrings == null || chapterStrings.length == 0) {
      print("no existing chapters found");
      List<String> chapterStrings = [];
      String chapterLink;

      try {
        var response = await Dio().get(
            "${env.endpoint}/search?author=${fav.author}&title=${fav.title}");
        print(response.data);
        for (var item in response.data) {
          Book book = Book.fromJson(item);
          if (book.site == fav.site) {
            chapterLink = book.chapterLink;
            break;
          }
        }
      } catch (e) {
        print(e);
      }
      print("chapterLink: $chapterLink");

      try {
        if (chapterLink != "") {
          var link =
              '${env.endpoint}/chapters?site=${fav.site}&link=$chapterLink';
          print(link);
          var response = await Dio().get("$link");
          print("response.data: ${response.data}");
          for (var item in response.data) {
            chapterStrings.add(json.encode(item));
            chapters.add(Chapter.fromJson(item));
          }
          print("chapterStrings: $chapterStrings");
          print("chapters: $chapters");
        }
        if (chapterStrings.length > 0) {
          Prefs.setStringList(fav.key, chapterStrings);
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("load existing chapters");
      for (var ch in chapterStrings) {
        Map<String, dynamic> chapJson = json.decode(ch);
        Chapter chap = Chapter.fromJson(chapJson);
        chapters.add(chap);
      }
      print("chapters in total: ${chapters.length}");
    }
  }
}
