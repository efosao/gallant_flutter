import 'package:flutter/material.dart';

class ImagesStore extends ChangeNotifier {
  final Map<String, List<String>> breedImages = Map();

  void add(String name, List<String> images) {
    breedImages.putIfAbsent(name, () => images);
    notifyListeners();
  }
}