Example demonstrating hot reloading on the web using package:build and
redux.dart

## Demo

To see this for yourself, follow these steps:

1. Use the Dart 2.0.0
2. run `pub get`
3. run `pub run build_runner serve --hot-reload`
4. Increment the counter a few times
5. In `reducers.dart`, change the `increment` value from `1` to `2`
file.
6. Increment the counter again. Notice that the state stays the same, but the
counter is incrementing by two!
