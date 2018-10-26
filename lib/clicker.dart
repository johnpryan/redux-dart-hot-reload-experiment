import 'dart:async';
import 'dart:html';

import 'package:hot_reload_experiment/clicker_reducer.dart';
import 'package:redux/redux.dart';

List<StreamSubscription> _subscriptions = [];
Store<int> store;

void _render(int state) {
  querySelector('#clicker #value').innerHtml = '$state';
}

void startClicker([int oldState = 0]) {
  store = Store<int>(clickerReducer, initialState: oldState);
  _subscriptions.add(store.onChange.listen(_render));
  _listenToButtons();
}

/// Listen for input events
void _listenToButtons() {
  _subscriptions.add(querySelector('#clicker #increment').onClick.listen((_) {
    store.dispatch(Actions.increment);
  }));

  _subscriptions.add(querySelector('#clicker  #decrement').onClick.listen((_) {
    store.dispatch(Actions.decrement);
  }));
}

void _cleanUpSubscriptions() {
  _subscriptions.forEach((s) => s.cancel());
  _subscriptions.clear();
}

Object hot$onDestroy() {
  _cleanUpSubscriptions();
  return store.state;
}

bool hot$onSelfUpdate(oldState) {
  startClicker(oldState);
  return true;
}
