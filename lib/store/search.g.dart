// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

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
    super.searchKeywordsFuture = value;
    _$searchKeywordsFutureAtom.reportChanged();
  }

  final _$_SearchStoreActionController = ActionController(name: '_SearchStore');

  @override
  void loadHistory() {
    final _$prevDerivation = _$_SearchStoreActionController.startAction();
    try {
      return super.loadHistory();
    } finally {
      _$_SearchStoreActionController.endAction(_$prevDerivation);
    }
  }

  @override
  void abort() {
    final _$prevDerivation = _$_SearchStoreActionController.startAction();
    try {
      return super.abort();
    } finally {
      _$_SearchStoreActionController.endAction(_$prevDerivation);
    }
  }
}
