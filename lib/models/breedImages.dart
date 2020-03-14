import 'package:json_annotation/json_annotation.dart';

part 'breedImages.g.dart';

@JsonSerializable()
class BreedImages {
  BreedImages(this.message);

  List<String> message;

  factory BreedImages.fromJson(Map<String, dynamic> json) => _$BreedImagesFromJson(json);

  Map<String, dynamic> toJson() => _$BreedImagesToJson(this);
}