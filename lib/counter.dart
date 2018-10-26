import 'dart:async';
import 'dart:html';

import 'package:hot_reload_experiment/counter_reducer.dart';
import 'package:redux/redux.dart';

List<dynamic> _subscriptions = [];
Store<int> store;

void _render(int state) {
  querySelector('#counter #value').innerHtml = '$state';
}

void startCounter([int oldState = 0]) {
  store = Store<int>(counterReducer, initialState: oldState);
  _subscriptions.add(store.onChange.listen(_render));
  _startTimer();
}

void _startTimer() {
  _subscriptions.add(Timer.periodic(new Duration(seconds: 1), (_) {
    store.dispatch(Actions.increment);
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
  startCounter(oldState);
  return true;
}
