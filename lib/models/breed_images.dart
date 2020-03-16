import 'package:json_annotation/json_annotation.dart';

part 'breed_images.g.dart';

@JsonSerializable()
class BreedImages {
  BreedImages(this.message);

  List<String> message;

  factory BreedImages.fromJson(Map<String, dynamic> json) => _$BreedImagesFromJson(json);

  Map<String, dynamic> toJson() => _$BreedImagesToJson(this);
}