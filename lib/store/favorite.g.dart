// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies

mixin _$FavoriteStore on _FavoriteStore, Store {
  Computed<bool> _$updatedComputed;

  @override
  bool get updated =>
      (_$updatedComputed ??= Computed<bool>(() => super.updated)).value;

  final _$favoritesAtom = Atom(name: '_FavoriteStore.favorites');

  @override
  ObservableList<Favorite> get favorites {
    _$favoritesAtom.reportObserved();
    return super.favorites;
  }

  @override
  set favorites(ObservableList<Favorite> value) {
    mainContext.checkIfStateModificationsAreAllowed(_$favoritesAtom);
    super.favorites = value;
    _$favoritesAtom.reportChanged();
  }

  final _$isFavoriteAtom = Atom(name: '_FavoriteStore.isFavorite');

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportObserved();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    mainContext.checkIfStateModificationsAreAllowed(_$isFavoriteAtom);
    super.isFavorite = value;
    _$isFavoriteAtom.reportChanged();
  }

  final _$loadedAtom = Atom(name: '_FavoriteStore.loaded');

  @override
  bool get loaded {
    _$loadedAtom.reportObserved();
    return super.loaded;
  }

  @override
  set loaded(bool value) {
    mainContext.checkIfStateModificationsAreAllowed(_$loadedAtom);
    super.loaded = value;
    _$loadedAtom.reportChanged();
  }

  final _$fetchFavsFutureAtom = Atom(name: '_FavoriteStore.fetchFavsFuture');

  @override
  ObservableFuture<List<Favorite>> get fetchFavsFuture {
    _$fetchFavsFutureAtom.reportObserved();
    return super.fetchFavsFuture;
  }

  @override
  set fetchFavsFuture(ObservableFuture<List<Favorite>> value) {
    mainContext.checkIfStateModificationsAreAllowed(_$fetchFavsFutureAtom);
    super.fetchFavsFuture = value;
    _$fetchFavsFutureAtom.reportChanged();
  }

  final _$_FavoriteStoreActionController =
      ActionController(name: '_FavoriteStore');

  @override
  dynamic checkFavritesUpdate() {
    final _$actionInfo = _$_FavoriteStoreActionController.startAction();
    try {
      return super.checkFavritesUpdate();
    } finally {
      _$_FavoriteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadFavorites() {
    final _$actionInfo = _$_FavoriteStoreActionController.startAction();
    try {
      return super.loadFavorites();
    } finally {
      _$_FavoriteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFavoriteStatus(Book book) {
    final _$actionInfo = _$_FavoriteStoreActionController.startAction();
    try {
      return super.setFavoriteStatus(book);
    } finally {
      _$_FavoriteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void flipFavorite(Book book) {
    final _$actionInfo = _$_FavoriteStoreActionController.startAction();
    try {
      return super.flipFavorite(book);
    } finally {
      _$_FavoriteStoreActionController.endAction(_$actionInfo);
    }
  }
}
