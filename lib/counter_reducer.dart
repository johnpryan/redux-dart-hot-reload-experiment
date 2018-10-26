enum Actions { increment }

/// Update these values while running with the --hot-reload flag to hot-reload
/// the functionality of the app without changing the state.
const increment = 4;

int counterReducer(int state, dynamic action) {
  if (action == Actions.increment) {
    return state + increment;
  }

  return state;
}
