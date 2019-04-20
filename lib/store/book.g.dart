// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$BookStore on _BookStore, Store {
  final _$booksAtom = Atom(name: '_BookStore.books');

  @override
  ObservableList<Book> get books {
    _$booksAtom.reportObserved();
    return super.books;
  }

  @override
  set books(ObservableList<Book> value) {
    super.books = value;
    _$booksAtom.reportChanged();
  }

  final _$loadedAtom = Atom(name: '_BookStore.loaded');

  @override
  bool get loaded {
    _$loadedAtom.reportObserved();
    return super.loaded;
  }

  @override
  set loaded(bool value) {
    super.loaded = value;
    _$loadedAtom.reportChanged();
  }

  final _$fetchFavsFutureAtom = Atom(name: '_BookStore.fetchFavsFuture');

  @override
  ObservableFuture<List<Book>> get fetchFavsFuture {
    _$fetchFavsFutureAtom.reportObserved();
    return super.fetchFavsFuture;
  }

  @override
  set fetchFavsFuture(ObservableFuture<List<Book>> value) {
    super.fetchFavsFuture = value;
    _$fetchFavsFutureAtom.reportChanged();
  }

  final _$_BookStoreActionController = ActionController(name: '_BookStore');

  @override
  void loadBook(Book book) {
    final _$prevDerivation = _$_BookStoreActionController.startAction();
    try {
      return super.loadBook(book);
    } finally {
      _$_BookStoreActionController.endAction(_$prevDerivation);
    }
  }

  @override
  void setBookStatus(Book book) {
    final _$prevDerivation = _$_BookStoreActionController.startAction();
    try {
      return super.setBookStatus(book);
    } finally {
      _$_BookStoreActionController.endAction(_$prevDerivation);
    }
  }
}
