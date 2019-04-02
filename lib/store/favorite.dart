import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:prunusavium/env.dart';
import 'package:prunusavium/model/book.dart';
import 'package:prunusavium/model/chapter.dart';
import 'package:prunusavium/model/favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorite.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore implements Store {
  final Env env;
  final SharedPreferences prefs;

  _FavoriteStore(this.env, this.prefs);

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

    var favStrings = prefs.getStringList("favorites");
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
    Favorite newf =
        Favorite(book.author, book.id, book.image, book.site, book.title, "");

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

    prefs.setStringList('favorites', favStrings);

    isFavorite = !isFavorite;
  }

  @action
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
    String text = prefs.getString("${fav.key}-${fav.progress}");

    if (text == null) {
      print("no existing text found");
      print(
          "text link: ${env.endpoint}/v1/text?site=${fav.source}&link=${chapters[fav.progress].link}");
      final response = await Dio().get(
          "${env.endpoint}/v1/text?site=${fav.source}&link=${chapters[fav.progress].link}");
      print("${response.data}");
      text = response.data;
      prefs.setString("${fav.key}-${fav.progress}", text);
    }

    print("load existing text");
    return text;
  }

  Future loadChapter(Favorite fav, List<Chapter> chapters) async {
    var chapterStrings = prefs.getStringList(fav.key);
    if (chapterStrings == null) {
      print("no existing chapters found");
      List<String> chapterStrings = [];
      String chapterLink;

      try {
        var response = await Dio().get(
            "${env.endpoint}/v1/search?author=${fav.author}&title=${fav.title}");
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
              '${env.endpoint}/v1/chapters?site=${fav.site}&link=$chapterLink';
          print(link);
          var response = await Dio().get("${link}");
          print("response.data: ${response.data}");
          for (var item in response.data) {
            chapterStrings.add(json.encode(item));
            chapters.add(Chapter.fromJson(item));
          }
          print("chapterStrings: $chapterStrings");
          print("chapters: $chapters");
        }
        prefs.setStringList(fav.key, chapterStrings);
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
