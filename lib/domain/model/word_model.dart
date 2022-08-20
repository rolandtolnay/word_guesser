import 'package:json_annotation/json_annotation.dart';

part 'word_model.g.dart';

@JsonSerializable()
class WordModel {
  WordModel(this.id, this.languages, this.imageUrl);

  final String id;
  final Map<String, String> languages;
  final String imageUrl;

  factory WordModel.fromJson(Map<String, dynamic> json) =>
      _$WordModelFromJson(json);

  Map<String, dynamic> toJson() => _$WordModelToJson(this);
}
