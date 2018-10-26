import 'package:redux/redux.dart';

Store<int> store;

Object hot$onDestroy() {
  print("store is being thrown away");
}