import 'package:hot_reload_experiment/clicker.dart';
import 'package:hot_reload_experiment/counter.dart';

void main() {
  // main() gets re-run every time hot reload is called. When this happens,
  // package:build will not throw away the Store object. But the Store object
  // still retains a reference to the *old* `counterReducer` method.
  //
  // Therefore, the Store must be re-created and the app must be re-rendered,
  // but the state can stay the same!
  startClicker();
  startCounter();
}
