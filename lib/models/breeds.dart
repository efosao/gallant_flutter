import 'package:json_annotation/json_annotation.dart';

part 'breeds.g.dart';

@JsonSerializable()
class Breeds {
  Breeds(this.message);

  Map<String, List<String>> message;

  factory Breeds.fromJson(Map<String, dynamic> json) => _$BreedsFromJson(json);

  Map<String, dynamic> toJson() => _$BreedsToJson(this);
}