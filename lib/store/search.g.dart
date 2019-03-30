// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies

mixin _$SearchStore on _SearchStore, Store {
  Computed<bool> _$hasResultsComputed;

  @override
  bool get hasResults =>
      (_$hasResultsComputed ??= Computed<bool>(() => super.hasResults)).value;

  final _$historyAtom = Atom(name: '_SearchStore.history');

  @override
  List<String> get history {
    _$historyAtom.reportObserved();
    return super.history;
  }

  @override
  set history(List<String> value) {
    mainContext.checkIfStateModificationsAreAllowed(_$historyAtom);
    super.history = value;
    _$historyAtom.reportChanged();
  }

  final _$searchKeywordsFutureAtom =
      Atom(name: '_SearchStore.searchKeywordsFuture');

  @override
  ObservableFuture get searchKeywordsFuture {
    _$searchKeywordsFutureAtom.reportObserved();
    return super.searchKeywordsFuture;
  }

  @override
  set searchKeywordsFuture(ObservableFuture value) {
    mainContext.checkIfStateModificationsAreAllowed(_$searchKeywordsFutureAtom);
    super.searchKeywordsFuture = value;
    _$searchKeywordsFutureAtom.reportChanged();
  }

  final _$searchKeywordsAsyncAction = AsyncAction('searchKeywords');

  @override
  Future<dynamic> searchKeywords(dynamic query) {
    return _$searchKeywordsAsyncAction.run(() => super.searchKeywords(query));
  }

  final _$_SearchStoreActionController = ActionController(name: '_SearchStore');

  @override
  void loadHistory() {
    final _$actionInfo = _$_SearchStoreActionController.startAction();
    try {
      return super.loadHistory();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }
}
