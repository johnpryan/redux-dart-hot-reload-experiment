import 'dart:async';
import 'dart:html';

import 'package:hot_reload_experiment/reducers.dart';
import 'package:redux/redux.dart';

List<StreamSubscription> _subscriptions = [];
Store<int> store;

void render(int state) {
  querySelector('#value').innerHtml = '$state';
}

void main() {
  // main() gets re-run every time hot reload is called. When this happens,
  // package:build will not throw away the Store object. But the Store object
  // still retains a reference to the *old* `counterReducer` method.
  //
  // Therefore, the Store must be re-created and the app must be re-rendered,
  // but the state can stay the same!
  runApp();
}

void runApp([int oldState = 0]) {
  store = Store<int>(counterReducer, initialState: oldState);
  _subscriptions.add(store.onChange.listen(render));
  _listenToButtons();
}

/// Listen for input events
void _listenToButtons() {
  _subscriptions.add(querySelector('#increment').onClick.listen((_) {
    store.dispatch(Actions.increment);
  }));

  _subscriptions.add(querySelector('#decrement').onClick.listen((_) {
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
  runApp(oldState);
  return true;
}
