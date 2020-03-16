// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed_images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedImages _$BreedImagesFromJson(Map<String, dynamic> json) {
  return BreedImages(
    (json['message'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$BreedImagesToJson(BreedImages instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
