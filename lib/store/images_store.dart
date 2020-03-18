
import 'package:flutter/foundation.dart';

class ImagesStore with ChangeNotifier {
  final Map<String, List<String>> breedImages = Map();

  void add(String name, List<String> images) {
    breedImages.putIfAbsent(name, () => images);
    notifyListeners();
  }
}