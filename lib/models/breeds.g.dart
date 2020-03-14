// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Breeds _$BreedsFromJson(Map<String, dynamic> json) {
  return Breeds(
    (json['message'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as List)?.map((e) => e as String)?.toList()),
    ),
  );
}

Map<String, dynamic> _$BreedsToJson(Breeds instance) => <String, dynamic>{
      'message': instance.message,
    };
