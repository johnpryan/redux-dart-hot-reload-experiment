enum Actions { increment, decrement }

/// Update these values while running with the --hot-reload flag to hot-reload
/// the functionality of the app without changing the state.
const increment = 5;
const decrement = 1;

int counterReducer(int state, dynamic action) {
  if (action == Actions.increment) {
    return state + increment;
  } else if (action == Actions.decrement) {
    return state - decrement;
  }

  return state;
}
