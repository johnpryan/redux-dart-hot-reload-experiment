import 'dart:async';
import 'dart:html';

import 'package:hot_reload_experiment/store.dart';
import 'package:hot_reload_experiment/reducers.dart';
import 'package:redux/redux.dart';

StreamSubscription<int> _subscription;

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
  if (store == null) {
    store = Store<int>(counterReducer, initialState: 0);
  } else {
    var oldStore = store;
    store = Store<int>(counterReducer, initialState: oldStore.state);
  }

  _subscription?.cancel();
  _subscription = store.onChange.listen(render);

  _listenToButtons();
}

/// Listen for input events
void _listenToButtons() {
  querySelector('#increment').onClick.listen((_) {
    store.dispatch(Actions.increment);
  });

  querySelector('#decrement').onClick.listen((_) {
    store.dispatch(Actions.decrement);
  });
}

void _cleanUpSubscriptions() {
  _subscription.cancel();
}

Object hot$onDestroy() {
  _cleanUpSubscriptions();
}
