import 'dart:convert';

import 'package:flutter_doggopedia/models/breed_images.dart';
import 'package:flutter_doggopedia/models/breeds.dart';
import 'package:http/http.dart' as http;

Future<Breeds> getBreeds () async {
  var url = 'https://dog.ceo/api/breeds/list/all';
  var response = await http.get(url);
  Map<String, dynamic> json = jsonDecode(response.body);
  var breeds = Breeds.fromJson(json);
  return breeds;
}

Future<BreedImages> getBreedImages (String breed) async {
  var url = 'https://dog.ceo/api/breed/$breed/images';
  var response = await http.get(url);
  Map<String, dynamic> json = jsonDecode(response.body);
  var breedImages = BreedImages.fromJson(json);
  return breedImages;
}
