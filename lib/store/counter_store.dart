
import 'package:flutter/foundation.dart';

class CounterStore with ChangeNotifier {
  var count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}